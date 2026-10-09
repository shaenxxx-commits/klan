# HANDOFF CURRENT — ЛЧ

**Дата:** 2026-10-09
**Статус:** актуальный
**Основание:** handoff-protocol LAB (адаптируется)

Снимок текущего состояния ЛЧ. Передаётся новому
ведущему при смене чата.

## CURRENT STATE

    HEAD: n/a (git не инициализирован)
    ACTIVE PHASE: documentation-setup
    STATUS: open
    LAST COMPLETED: записан рабочий слой meta/
                    (operator-preferences)
    WORKING HYPOTHESES:
      - ДДА v0.4 согласована и записана на диск.
      - Репозиторий пока не инициализирован.
    KNOWN UNKNOWNs:
      - Git identity для репозитория не решён.
      - Схема маскирования не зафиксирована.
      - Pre-commit проверки отсутствуют.
      - Права на каталоги пока 775/664 (umask 0002).
    PENDING DECISION:
      - git init + первый коммит.
      - Git identity (локальная vs глобальная).
      - Ужесточение прав до 750/640.
      - Наполнение raw/.
    LAST RESPONSE NUMBER: MS50

## Repository

- LCH: ~/lch (git не инициализирован)
- LAB (external source, метод координации):
  /home/shaen/nova-cortex-lab
- ENVOY (параллельная пилотная ветка):
  /home/shaen/envoy

## Структура

    lch/
    ├── README.md
    ├── docs/           — AGENT, CONCEPT, CURRENT_STATE,
    │                     ONTOLOGY, DECISIONS, REDACTIONS
    ├── meta/           — operator-preferences,
    │                     handoff-current
    ├── raw/
    ├── sensitive/
    │   └── quarantine/
    └── evidence/

## Роли

- Architect: shaen (Оператор)
- Lead: текущий ведущий
- External: резерв, для критических прогонов
  (Kimi, Sakana/Namazu, Grok)

## Что не сделано

- Git-репозиторий не инициализирован.
- raw/ не наполнен.
- open-questions.md не создан.
- Схема маскирования не зафиксирована.
- Pre-commit проверки отсутствуют.

## Где смотреть

- docs/AGENT.md — точка входа
- docs/CONCEPT.md — метод
- docs/DECISIONS.md — журнал решений
- meta/operator-preferences.md — правила работы
- LAB (/home/shaen/nova-cortex-lab) — источник метода
