# CURRENT_STATE.md — Личный корпус (ЛЧ)

Снимок состояния. Обновляется после каждой значимой
итерации. Не канон.

## Что есть

- Структура каталогов: docs/, meta/, raw/, sensitive/,
  sensitive/quarantine/, evidence/.
- .gitignore.
- README.md.
- ДДА: AGENT.md, CONCEPT.md, CURRENT_STATE.md,
  ONTOLOGY.md, DECISIONS.md, REDACTIONS.md.
- meta/: operator-preferences.md, handoff-current.md,
  open-questions.md.
- Git-репозиторий инициализирован. Ветка main.
  Первый коммит: 9756f69.
- Git identity локальная: LCH Kuchuk <maia.systems@proton.me>.
- Права каталогов 750, файлов 640. umask 0027 в ~/.bashrc.

## Что отсутствует

- Наполнение данными (raw/ пуст).
- Pre-commit проверки.
- Детальная схема маскирования.
- Удалённый remote.

## Физическая структура

    lch/
    ├── README.md
    ├── docs/           # ДДА
    ├── meta/           # рабочий слой
    ├── raw/            # необработанные материалы
    ├── sensitive/      # чувствительные данные (вне git)
    │   └── quarantine/
    └── evidence/       # подтверждённые артефакты

## Ближайшие шаги

1. Первое наполнение raw/.
2. Решение по Q3 (MASKING.md vs раздел в CONCEPT).
3. Решение по Q4 (pre-commit).
4. При необходимости — remote.

## Открытые вопросы

См. meta/open-questions.md.
