# HANDOFF CURRENT — ЛЧ

**Дата:** 2026-10-09
**Статус:** актуальный
**Основание:** handoff-protocol LAB (адаптируется)

Снимок текущего состояния ЛЧ. Передаётся новому
ведущему при смене чата.

## CURRENT STATE

    HEAD: 4b06403 (main)
    ACTIVE PHASE: documentation-setup
    STATUS: open
    LAST COMPLETED: CURRENT_STATE обновлён после init
    WORKING HYPOTHESES:
      - ДДА v0.4 записана на диск и закоммичена.
      - Репозиторий инициализирован, локальная identity.
      - Права 750/640, umask 0027.
    KNOWN UNKNOWNs:
      - Схема маскирования не зафиксирована (Q3).
      - Pre-commit проверки отсутствуют (Q4).
      - Remote не настроен.
    PENDING DECISION:
      - Q3: MASKING.md vs раздел в CONCEPT.
      - Q4: pre-commit hook — что и чем.
      - Первое наполнение raw/.
    LAST RESPONSE NUMBER: MS72

## Repository

- LCH: ~/lch (git init, main, 2 коммита)
  - 9756f69 init: LCH v0.4 — ДДА, meta, README
  - 4b06403 docs: update CURRENT_STATE after init
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
    │                     handoff-current, open-questions
    ├── raw/            — пуст
    ├── sensitive/      — вне git
    │   └── quarantine/
    └── evidence/       — пуст

## Роли

- Architect: shaen (Оператор)
- Lead: текущий ведущий
- External: резерв, для критических прогонов
  (Kimi, Sakana/Namazu, Grok)

## Что не сделано

- raw/ не наполнен.
- Q3, Q4 не закрыты.
- Remote не настроен.

## Где смотреть

- docs/AGENT.md — точка входа
- docs/CONCEPT.md — метод
- docs/DECISIONS.md — журнал решений
- meta/operator-preferences.md — правила работы
- meta/open-questions.md — открытые вопросы
- LAB (/home/shaen/nova-cortex-lab) — источник метода
