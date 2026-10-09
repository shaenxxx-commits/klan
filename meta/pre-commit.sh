#!/usr/bin/env bash
# LCH pre-commit guard.
# Установка: ln -sf ../../meta/pre-commit.sh .git/hooks/pre-commit
# Проверки:
#   1. Блокировать любые файлы из sensitive/.
#   2. Блокировать файлы, совпадающие с чувствительными
#      расширениями/именами из .gitignore.
#   3. Предупреждать (не блокировать) при коммите из raw/.

set -e

BLOCKED=0

STAGED=$(git diff --cached --name-only --diff-filter=ACM)

# 1. sensitive/
for f in $STAGED; do
  case "$f" in
    sensitive/*|*/sensitive/*)
      echo "BLOCKED: sensitive file staged: $f" >&2
      BLOCKED=1
      ;;
  esac
done

# 2. чувствительные расширения / имена
for f in $STAGED; do
  case "$f" in
    *.id.*|*.scan.pdf|.env|*.key|*.secret|*.pem|config.local.*)
      echo "BLOCKED: sensitive pattern staged: $f" >&2
      BLOCKED=1
      ;;
  esac
done

if [ "$BLOCKED" -eq 1 ]; then
  echo "Commit aborted. Use --no-verify only after explicit decision." >&2
  exit 1
fi

# 3. raw/ — предупреждение
RAW=$(echo "$STAGED" | grep -E '^raw/' || true)
if [ -n "$RAW" ]; then
  echo "WARNING: raw/ files staged:"
  echo "$RAW"
  echo "Proceeding. Ensure no sensitive content."
fi

exit 0
