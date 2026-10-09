# CURRENT_STATE.md — Личный корпус (ЛЧ)

Снимок состояния. Обновляется после каждой значимой
итерации. Не канон.

## Что есть

- Структура каталогов: docs/, raw/, sensitive/,
  sensitive/quarantine/, evidence/, meta/.
- .gitignore.
- README.md.
- ДДА: AGENT.md, CONCEPT.md.

## Что отсутствует

- Наполнение данными.
- ONTOLOGY.md, DECISIONS.md, REDACTIONS.md.
- meta/ (handoff-current, operator-preferences,
  open-questions).
- Инициализация git-репозитория.
- Pre-commit проверки.
- Детальная схема маскирования.

## Физическая структура (ожидаемая)

    lch/
    ├── README.md
    ├── docs/           # ДДА
    ├── meta/           # рабочий слой
    ├── raw/            # необработанные материалы
    ├── sensitive/      # чувствительные данные (вне git)
    │   └── quarantine/
    └── evidence/       # подтверждённые артефакты

## Ближайшие шаги

1. Записать ONTOLOGY.md, DECISIONS.md, REDACTIONS.md.
2. Создать meta/ и наполнить.
3. Инициализировать git-репозиторий.
4. Первое наполнение raw/.

## Открытые вопросы

- Физическое расположение evidence и long-term
  хранение карантина.
- Порядок доступа разных LLM-агентов
  (локальные vs внешние).
- Git identity для репозитория.
