# CURRENT_STATE.md — KLAN

Знімок стану. Оновлюється після кожної значущої
ітерації. Не канон.

## Що є

- Структура каталогів: docs/, meta/, raw/, sensitive/,
  sensitive/quarantine/, evidence/.
- .gitignore.
- README.md.
- ДДА: AGENT.md, CONCEPT.md, CURRENT_STATE.md,
  ONTOLOGY.md, DECISIONS.md, REDACTIONS.md.
- meta/: operator-preferences.md, handoff-current.md,
  open-questions.md, pre-commit.sh.
- meta/externals/: README.md з правилами прогонів.
- Git-репозиторій. Гілка main. Remote на GitHub.
- Git identity локальна: LCH Kuchuk <maia.systems@proton.me>.
- Публічний метод-шар: https://github.com/shaenxxx-commits/klan
- Права каталогів 750, файлів 640. umask 0027 у ~/.bashrc.
- Pre-commit guard активний.

## Що відсутнє

- Наповнення даними (raw/ порожній).
- Схема маскування.
- Бекап-схема поза локальним носієм.
- Перший прогін зовнішніх.

## Фізична структура

    lch/
    ├── README.md
    ├── docs/           # ДДА
    ├── meta/           # робочий шар
    │   └── externals/  # журнали прогонів
    ├── raw/            # необроблені матеріали (поза git)
    ├── sensitive/      # чутливі дані (поза git)
    │   └── quarantine/
    └── evidence/       # артефакти (поза git)

## Публічність

Публічний метод-шар: README, docs/, meta/.
Дані (raw/, sensitive/, evidence/) — окремо,
ніколи не потрапляють у публічний репо.

## Найближчі кроки

1. Перший прогін зовнішніх (GPT-5.6 Luna,
   Kimi K2 Thinking, Qwen3.7-Plus).
2. Q9 — бекап-схема.
3. Q3 — маскування.
4. Q10 — конвеєр сканів.

## Відкриті питання

Див. meta/open-questions.md.
