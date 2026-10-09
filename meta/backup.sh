#!/usr/bin/env bash
# KLAN backup to Proton Drive.
# Бекапить sensitive/, raw/, evidence/ у /my-files/KLAN/backup/.
# Ротація: зберігає 3 останні архіви.

set -euo pipefail

LCH="$HOME/lch"
DATE=$(date +%Y-%m-%d)
ARCHIVE="/tmp/klan-backup-${DATE}.tar.gz"
REMOTE_DIR="/my-files/KLAN/backup"
KEEP=3

echo "[$(date '+%Y-%m-%d %H:%M:%S')] backup start"

# 1. Перевірка, що каталоги існують
for d in sensitive raw evidence; do
  if [ ! -d "$LCH/$d" ]; then
    echo "missing directory: $LCH/$d" >&2
    exit 1
  fi
done

# 2. Пакування
tar -czf "$ARCHIVE" -C "$LCH" sensitive raw evidence
SIZE=$(du -h "$ARCHIVE" | cut -f1)
echo "packed: $ARCHIVE ($SIZE)"

# 3. Заливка
proton-drive filesystem upload "$ARCHIVE" "$REMOTE_DIR"
echo "uploaded to $REMOTE_DIR"

# 4. Очищення локального
rm -f "$ARCHIVE"

# 5. Ротація: залишити KEEP останніх
LIST=$(proton-drive filesystem list "$REMOTE_DIR" --json \
  | jq -r '.[].name.value' \
  | grep -E '^klan-backup-[0-9-]+\.tar\.gz$' \
  | sort -r)
COUNT=$(echo "$LIST" | grep -c . || true)
if [ "$COUNT" -gt "$KEEP" ]; then
  echo "$LIST" | tail -n +$((KEEP + 1)) | while read -r old; do
    echo "removing old: $old"
    proton-drive filesystem delete "$REMOTE_DIR/$old"
  done
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] backup done"
