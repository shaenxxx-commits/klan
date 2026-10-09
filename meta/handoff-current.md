# HANDOFF CURRENT — KLAN

**Дата:** 2026-10-09
**Статус:** актуальний
**Основа:** handoff-protocol LAB (адаптується)

Знімок поточного стану KLAN. Передається новому
ведучому при зміні чату.

## CURRENT STATE

    HEAD: 2a35882 (main)
    ACTIVE PHASE: мовний перехід + перейменування
    STATUS: open
    LAST COMPLETED: Q7.1-Q7.4 вирішено;
                    переклад ДДА на українську
    WORKING HYPOTHESES:
      - Мова проєкту — українська.
      - Назва KLAN (латиниця), кирилицею КЛАН.
      - Метки знання і статуси — англійською.
    KNOWN UNKNOWNs:
      - Бекап-схема (Q9).
      - Схема маскування (Q3).
      - Конвеєр сканів (Q10).
      - Зовнішній доступ (Q8).
    PENDING DECISION:
      - Q9: провайдер, фізичний носій, шифрування.
      - Q10: класи документів, OCR, структура.
      - Q8: спосіб доступу зовнішніх.
    LAST RESPONSE NUMBER: MS114

## Repository

- KLAN: ~/lch (git init, main)
- LAB (external source, метод координації):
  /home/shaen/nova-cortex-lab
- ENVOY (паралельна пілотна гілка):
  /home/shaen/envoy

## Структура

    lch/
    ├── README.md
    ├── docs/           — AGENT, CONCEPT, CURRENT_STATE,
    │                     ONTOLOGY, DECISIONS, REDACTIONS
    ├── meta/           — operator-preferences,
    │                     handoff-current, open-questions,
    │                     pre-commit.sh
    ├── raw/            — порожній
    ├── sensitive/      — поза git
    │   └── quarantine/
    └── evidence/       — порожній

## Ролі

- Architect: shaen (Оператор)
- Lead: поточний ведучий
- External: резерв, для критичних прогонів
  (GPT-5.6 Luna, Kimi K2 Thinking, Qwen3.7-Plus)

## Що не зроблено

- Q8-Q10 не закриті.
- Remote не налаштовано.
- raw/ не наповнено.

## Де дивитись

- docs/AGENT.md — точка входу
- docs/CONCEPT.md — метод
- docs/DECISIONS.md — журнал рішень
- meta/operator-preferences.md — правила роботи
- meta/open-questions.md — відкриті питання
- LAB (/home/shaen/nova-cortex-lab) — джерело методу
