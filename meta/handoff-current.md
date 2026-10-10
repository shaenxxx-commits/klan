# HANDOFF CURRENT — KLAN

**Дата:** 2026-10-10
**Статус:** актуальний
**Основа:** handoff-protocol LAB (адаптується)

Знімок поточного стану KLAN. Передається новому
ведучому при зміні чату.

## CURRENT STATE

    HEAD: 1acd2a5 (main = origin/main)
    ACTIVE PHASE: roadmap phase 3 (DEFERRED до появи даних)
    STATUS: open
    LAST COMPLETED: 2.3 Q10 (SCANS.md, baseline)
    WORKING HYPOTHESES:
      - Мова проєкту — українська.
      - Назва KLAN (латиниця), кирилицею КЛАН.
      - Метки знання і статуси мета-шару — англійською.
      - Публічний метод-шар (docs/, meta/, README).
      - Дані (raw/, sensitive/, evidence/) — ніколи
        не в публічний репо.
    KNOWN UNKNOWNs:
      - Q5, Q6 — DEFERRED.
      - Q10 — закрито як baseline, ревізія при появі даних.
      - Q9.2 (фізичний носій в іншій локації) — DEFERRED.
    PENDING DECISION:
      - External run 3 (після закриття Фази 2).

## Repository

- KLAN: ~/lch (git main, remote origin)
  https://github.com/shaenxxx-commits/klan
- LAB (method source):
  https://github.com/shaenxxx-commits/nova-cortex-lab
- Envoy (parallel pilot):
  https://github.com/shaenxxx-commits/envoy
- novohalyshchyna-repo (public community project,
  source of two practices adopted):
  https://github.com/shaenxxx-commits/novohalyshchyna-repo
  Local clone: ~/novohalyshchyna-repo

## Structure

    lch/
    ├── README.md
    ├── docs/           — AGENT, CONCEPT, CURRENT_STATE,
    │                     ONTOLOGY, DECISIONS, REDACTIONS,
    │                     LINEAGE, MASKING
    ├── meta/           — operator-preferences,
    │                     handoff-current, open-questions,
    │                     roadmap, pre-commit.sh, backup.sh
    │   └── externals/  — README + 6 runs + 2 SYNTHESIS
    ├── raw/            — поза git, порожній
    ├── sensitive/      — поза git, порожній
    │   └── quarantine/
    └── evidence/       — поза git, порожній

## Infrastructure

- Git identity local: LCH Kuchuk <maia.systems@proton.me>
- Permissions: 750/640, umask 0027 у ~/.bashrc
- Pre-commit guard: meta/pre-commit.sh, symlink
- Backup: meta/backup.sh + systemd user timer
  (klan-backup.timer, 03:00 daily, Persistent=true)
  → Proton Drive /my-files/KLAN/backup/
  Proton CLI: ~/.local/bin/proton-drive (v0.9.0)
  Linger: enabled
- Rotation: 3 archives

## External runs

Run1 (2026-10-09, GitHub UI URLs):
- gpt-6, kimi-k2-thinking, qwen3.7
- Problem: files unread, answers based on snippets
- SYNTHESIS: 2026-10-09-SYNTHESIS.md

Run2 (2026-10-09, raw-URLs):
- gpt-6: ACCESS_OK, new correct analysis
- kimi-k2-thinking: confabulation (cites non-existent
  elements), see warning in file
- qwen3.7: identical to run1 (cache/replay issue)
- SYNTHESIS: 2026-10-09-SYNTHESIS-run2.md

Usable: gpt-6. Conditional: kimi (require citation).
Verify: qwen.

## Roadmap state

Phase 1 (structural DDA): DONE (1.1-1.5)
Phase 2:
- 2.1 Q9 backup: DONE
- 2.2 Q3 masking: DONE
- 2.3 Q10 scans pipeline: DONE (baseline)
Phase 3 (data-dependent): DEFERRED (3.1, 3.2)

## Q-status

- Q1, Q2, Q3, Q4, Q7, Q8 — CLOSED
- Q5, Q6 — DEFERRED
- Q9 — CLOSED
- Q10 — CLOSED (baseline, 2026-10-10)

## Roles

- Architect: shaen (Operator)
- Lead: current
- External: GPT-6, Kimi K2 Thinking, Qwen3.7

## Adopted from novohalyshchyna-repo

- Principle: "no document before its function in
  documentary architecture is defined"
  (CONCEPT.md §5 → KLAN principle #8)
- OCR-rule: OCR text not verified for critical
  fields (PIB, numbers, dates) without visual check
  (CONCEPT.md, after E-levels)

## Not done

- Physical backup medium (deferred)
- Real data in raw/

## Where to look

- docs/AGENT.md — entry point
- docs/CONCEPT.md — method
- docs/DECISIONS.md — decision journal
- docs/LINEAGE.md — dependency map
- docs/MASKING.md — PII masking
- meta/roadmap.md — current work order
- meta/open-questions.md — open questions
- meta/operator-preferences.md — working rules
- meta/externals/ — external runs history
