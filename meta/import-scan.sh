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
EXPECTED_UUID="64D60B1ED60AEFDA"
INBOX="$MNT/KLAN/scan-inbox"
IMPORTED="$MNT/KLAN/.imported"
ORIGINALS="$LCH/sensitive/scans/_originals"
CLASSES=(identity civil medical property financial legal correspondence other)

DRY_RUN=0
case "${1:-}" in
  "")
    ;;
  --dry-run)
    DRY_RUN=1
    echo "[DRY RUN] жодних змін на диску не буде"
    ;;
  *)
    echo "ERROR: unknown argument: $1" >&2
    echo "usage: $0 [--dry-run]" >&2
    exit 2
    ;;
esac

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
  if [ "$DRY_RUN" -eq 1 ]; then
    log "(dry-run: skipping mount state change)"
    return 0
  fi
  log "remounting ro"
  mount_ro
}
trap cleanup EXIT

# --- sanity
[ -d "$LCH/sensitive" ] || { log "ERROR: $LCH/sensitive missing"; exit 1; }

log "import-scan start"

# A5: verify /mnt/shared is the expected NTFS
actual_uuid=$(findmnt -no UUID "$MNT" 2>/dev/null || true)
if [ "$actual_uuid" != "$EXPECTED_UUID" ]; then
  log "ERROR: $MNT is not the expected NTFS (UUID=$actual_uuid, expected=$EXPECTED_UUID)"
  exit 1
fi
log "source verified: $MNT UUID=$actual_uuid"

if [ "$DRY_RUN" -eq 0 ]; then
  mount_rw
  # re-verify after remount
  actual_uuid=$(findmnt -no UUID "$MNT" 2>/dev/null || true)
  if [ "$actual_uuid" != "$EXPECTED_UUID" ]; then
    log "ERROR: after remount UUID mismatch ($actual_uuid)"
    exit 1
  fi
  # A7: warn if INBOX missing (Windows side not set up)
  if [ ! -d "$INBOX" ]; then
    log "WARN: $INBOX not found — Windows side not yet configured"
  fi
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

    # A7: skip Windows system/temp files
    case "$base" in
      Thumbs.db|desktop.ini|.*|~*)
        log "  skip: $base (system/temp)"
        continue
        ;;
    esac
    ext="${base##*.}"
    ext_lc=$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')

    mtime=$(stat -c %Y "$f")
    date_part=$(date -d "@$mtime" +%Y%m%d)

    # --- find next NNN
    nnn=1
    while [ -d "$dst_root/$(printf '%s-%s-%03d' "$date_part" "$cls" "$nnn")" ]; do
      nnn=$((nnn+1))
      if [ "$nnn" -gt 999 ]; then
        log "  ERROR: NNN > 999 for $date_part-$cls (too many scans this day)"
        skipped=$((skipped+1))
        continue 2
      fi
    done
    id=$(printf '%s-%s-%03d' "$date_part" "$cls" "$nnn")
    dst_dir="$dst_root/$id"
    dst_file="$dst_dir/page-01.$ext_lc"

    if [ "$DRY_RUN" -eq 1 ]; then
      log "  [DRY] $base → $dst_file"
      log "  [DRY] then $base → $imp_dir/${id}__$base"
      processed=$((processed+1))
      continue
    fi

    mkdir -p "$dst_dir" "$imp_dir"
    chmod 750 "$dst_dir" "$imp_dir"

    cp --preserve=timestamps "$f" "$dst_file"
    chmod 640 "$dst_file"

    src_sum=$(sha256sum "$f" | awk '{print $1}')
    dst_sum=$(sha256sum "$dst_file" | awk '{print $1}')
    if [ "$src_sum" != "$dst_sum" ]; then
      log "  ERROR: checksum mismatch for $base"
      rm -f "$dst_file"
      rmdir "$dst_dir" 2>/dev/null || true
      skipped=$((skipped+1))
      continue
    fi

    # A2: collision-safe move to .imported
    imp_target="$imp_dir/${id}__$base"
    if [ -e "$imp_target" ]; then
      imp_target="$imp_dir/${id}__$(date +%s)__$base"
    fi
    mv "$f" "$imp_target"
    log "  $base → $id/page-01.$ext_lc  (imported, sum ${src_sum:0:12})"
    processed=$((processed+1))
  done
done

if [ "$processed" -eq 0 ] && [ "$skipped" -eq 0 ]; then
  log "WARN: nothing processed. Drop zone empty or Windows side not configured."
fi
log "import-scan done: processed=$processed skipped=$skipped"
