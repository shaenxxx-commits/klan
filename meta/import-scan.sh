#!/usr/bin/env bash
# KLAN import-scan.sh
# Переміщує скани з Windows NTFS inbox у ~/lch/sensitive/scans/_originals/.
#
# Потік:
#   S:\KLAN\scan-inbox\<class>\*.{png,jpg,jpeg}    (Windows, NTFS)
#     → ~/lch/sensitive/scans/_originals/<class>/<ID>/page-01.<ext>
#   оброблений файл → S:\KLAN\.imported\<class>\
#
# NTFS у fstab змонтований ro. Скрипт:
#   1. umount /mnt/shared
#   2. mount -o rw
#   3. copy + verify + move original → .imported
#   4. umount
#   5. mount (ro з fstab)
#
# trap EXIT гарантує повернення в ro, навіть при помилці.
#
# Використання:
#   meta/import-scan.sh            # реальний прогін
#   meta/import-scan.sh --dry-run  # показати, що буде зроблено
#
# Ідемпотентний: повторний запуск не створить дублікатів.

set -euo pipefail

LCH="$HOME/lch"
MNT="/mnt/shared"
INBOX="$MNT/KLAN/scan-inbox"
IMPORTED="$MNT/KLAN/.imported"
ORIGINALS="$LCH/sensitive/scans/_originals"
CLASSES=(identity civil medical property financial legal correspondence other)

DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=1
  echo "[DRY RUN] жодних змін на диску не буде"
fi

log() { printf '[%s] %s\n' "$(date '+%F %T')" "$*"; }

mount_ro() {
  sudo umount "$MNT" 2>/dev/null || true
  sudo mount "$MNT"
}

mount_rw() {
  sudo umount "$MNT" 2>/dev/null || true
  sudo mount -o rw "$MNT"
}

cleanup() {
  log "remounting ro"
  mount_ro
}
trap cleanup EXIT

# --- sanity
[ -d "$LCH/sensitive" ] || { log "ERROR: $LCH/sensitive missing"; exit 1; }

log "import-scan start"
if [ "$DRY_RUN" -eq 0 ]; then
  mount_rw
else
  log "(dry-run: skipping mount rw)"
fi

processed=0
skipped=0

for cls in "${CLASSES[@]}"; do
  src_dir="$INBOX/$cls"
  dst_root="$ORIGINALS/$cls"
  imp_dir="$IMPORTED/$cls"

  [ -d "$src_dir" ] || continue

  shopt -s nullglob nocaseglob
  files=("$src_dir"/*.png "$src_dir"/*.jpg "$src_dir"/*.jpeg)
  shopt -u nullglob nocaseglob

  if [ "${#files[@]}" -eq 0 ]; then
    continue
  fi

  log "class: $cls (${#files[@]} file(s))"

  for f in "${files[@]}"; do
    [ -f "$f" ] || continue
    base=$(basename "$f")
    ext="${base##*.}"
    ext_lc=$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')

    mtime=$(stat -c %Y "$f")
    date_part=$(date -d "@$mtime" +%Y%m%d)

    # --- find next NNN
    nnn=1
    while [ -d "$dst_root/$(printf '%s-%s-%03d' "$date_part" "$cls" "$nnn")" ]; do
      nnn=$((nnn+1))
    done
    id=$(printf '%s-%s-%03d' "$date_part" "$cls" "$nnn")
    dst_dir="$dst_root/$id"
    dst_file="$dst_dir/page-01.$ext_lc"

    if [ "$DRY_RUN" -eq 1 ]; then
      log "  [DRY] $base → $dst_file"
      log "  [DRY] then $base → $imp_dir/$base"
      processed=$((processed+1))
      continue
    fi

    mkdir -p "$dst_dir" "$imp_dir"

    cp --preserve=mode,timestamps "$f" "$dst_file"

    src_size=$(stat -c %s "$f")
    dst_size=$(stat -c %s "$dst_file")
    if [ "$src_size" -ne "$dst_size" ]; then
      log "  ERROR: size mismatch for $base ($src_size vs $dst_size)"
      rm -f "$dst_file"
      skipped=$((skipped+1))
      continue
    fi

    mv "$f" "$imp_dir/$base"
    log "  $base → $id/page-01.$ext_lc  (imported)"
    processed=$((processed+1))
  done
done

log "import-scan done: processed=$processed skipped=$skipped"
