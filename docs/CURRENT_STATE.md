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
- Git-репозиторій ініціалізовано. Гілка main.
- Git identity локальна: LCH Kuchuk <maia.systems@proton.me>.
- Права каталогів 750, файлів 640. umask 0027 у ~/.bashrc.
- Pre-commit guard активний.

## Що відсутнє

- Наповнення даними (raw/ порожній).
- Схема маскування.
- Бекап-схема поза локальним носієм.
- Віддалений remote.

## Фізична структура

    lch/
    ├── README.md
    ├── docs/           # ДДА
    ├── meta/           # робочий шар
    ├── raw/            # необроблені матеріали
    ├── sensitive/      # чутливі дані (поза git)
    │   └── quarantine/
    └── evidence/       # підтверджені артефакти

## Найближчі кроки

1. Бекап-схема (Q9).
2. Схема маскування (Q3).
3. Конвеєр сканів (Q10).
4. Зовнішній доступ (Q8).

## Відкриті питання

Див. meta/open-questions.md.
