# HANDOFF CURRENT — KLAN

**Дата:** 2026-10-09
**Статус:** актуальний
**Основа:** handoff-protocol LAB (адаптується)

Знімок поточного стану KLAN. Передається новому
ведучому при зміні чату.

## CURRENT STATE

    HEAD: bd8d381 (main = origin/main)
    ACTIVE PHASE: external-run-preparation
    STATUS: open
    LAST COMPLETED: Q8 закрито (публічний метод-шар);
                    meta/externals/ створено
    WORKING HYPOTHESES:
      - Мова проєкту — українська.
      - Назва KLAN (латиниця), кирилицею КЛАН.
      - Метки знання і статуси — англійською.
      - Зовнішні читають тільки публічний метод-шар.
    KNOWN UNKNOWNs:
      - Бекап-схема (Q9).
      - Схема маскування (Q3).
      - Конвеєр сканів (Q10).
      - Перший прогін зовнішніх не проведено.
    PENDING DECISION:
      - Q9: провайдер, фізичний носій, шифрування.
      - Q10: класи документів, OCR, структура.
      - Q3: MASKING.md vs розділ у CONCEPT.
    LAST RESPONSE NUMBER: MS138

## Repository

- KLAN: ~/lch (git init, main, remote origin)
  https://github.com/shaenxxx-commits/klan
- LAB (external source, метод координації):
  https://github.com/shaenxxx-commits/nova-cortex-lab
- Envoy (паралельна пілотна гілка):
  https://github.com/shaenxxx-commits/envoy

## Структура

    lch/
    ├── README.md
    ├── docs/           — AGENT, CONCEPT, CURRENT_STATE,
    │                     ONTOLOGY, DECISIONS, REDACTIONS
    ├── meta/           — operator-preferences,
    │                     handoff-current, open-questions,
    │                     pre-commit.sh
    │   └── externals/  — README + журнали прогонів
    ├── raw/            — поза git
    ├── sensitive/      — поза git
    │   └── quarantine/
    └── evidence/       — поза git

## Публічний метод-шар

У GitHub-репо потрапляють: README.md, docs/, meta/.
Не потрапляють: raw/, sensitive/, evidence/.

## Ролі

- Architect: shaen (Оператор)
- Lead: поточний ведучий
- External: GPT-5.6 Luna, Kimi K2 Thinking,
  Qwen3.7-Plus

## Що не зроблено

- Q3, Q9, Q10 не закриті.
- Перший прогін зовнішніх не проведено.
- raw/ не наповнено.
- Бекап-схема не налаштована.

## Де дивитись

- docs/AGENT.md — точка входу
- docs/CONCEPT.md — метод
- docs/DECISIONS.md — журнал рішень
- meta/operator-preferences.md — правила роботи
- meta/open-questions.md — відкриті питання
- meta/externals/README.md — правила прогонів
- LAB (https://github.com/shaenxxx-commits/nova-cortex-lab)
  — джерело методу
