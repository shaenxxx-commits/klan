# SYNTHESIS run3
# Author: lead (KLAN)
# Status: synthesis, not source transcript

meta:
  run_date: 2026-10-10
  synthesis_date: 2026-10-10
  head: d4cf954
  sources:
    - 2026-10-10-gpt-6-run3.md
    - 2026-10-10-kimi-k2-thinking-run3.md
    - 2026-10-10-qwen3.7-run3.md
  question_set: [a, b, c]

channel:
  - node: gpt-6
    access: OK
    calibration:
      strong: structure analysis
      weak: close-reading (missed 3 CONCEPT.md sections)
  - node: kimi
    access: OK
    calibration:
      change_vs_run2: no confabulation
      strong: precise citation
  - node: qwen
    access: OK
    calibration:
      change_vs_run2: no replay
      strong: unique findings

accepted:
  - id: F1
    finding: masking is not an explicit pipeline step
    evidence:
      - SCANS.md#Q10.4
      - MASKING.md#procedure
    sources: [gpt-6, kimi, qwen]
  - id: F2
    finding: sidecar vs ocrmypdf mismatch
    evidence:
      - SCANS.md#Q10.3
      - SCANS.md#Q10.4
    sources: [kimi, qwen]
  - id: F3
    finding: artifact identity/naming undefined
    evidence:
      - SCANS.md#Q10.4
    sources: [gpt-6, kimi, qwen]
  - id: F4
    finding: Q9 status contradiction across files
    evidence:
      - roadmap.md#2.1
      - open-questions.md#Q9
      - handoff-current.md
    sources: [gpt-6]
  - id: F5
    finding: EXIF not covered by masking scheme
    evidence:
      - MASKING.md#not-masked
    sources: [kimi]
  - id: F6
    finding: tag mechanism has no storage location
    evidence:
      - SCANS.md#Q10.1
      - SCANS.md#Q10.4
    sources: [qwen]
  - id: F7
    finding: masking-map loss risk (not covered by backup)
    evidence:
      - MASKING.md#procedure
      - handoff-current.md#infrastructure
    sources: [qwen]
  - id: F8
    finding: multipage document unit undefined
    evidence:
      - SCANS.md#Q10.2
      - SCANS.md#Q10.4
    sources: [gpt-6]
  - id: F9
    finding: PDF/A verification step missing
    evidence:
      - SCANS.md#Q10.2
    sources: [gpt-6]

rejected:
  - id: R1
    claim: actions 3,4,6 not closed
    reason: present in CONCEPT.md; kimi+qwen cited directly
    source: gpt-6#a
  - id: R2
    claim: ocrmypdf deskews by default
    reason: false; requires explicit --deskew flag
    source: [kimi#c, qwen#c]
  - id: R3
    claim: double-slash in Q10.4 paths
    reason: markdown artifact of <class> placeholder
    source: kimi#b

action_queue:
  - id: A1
    action: reconcile Q9 status across 3 files
    target: [roadmap, open-questions, handoff]
    priority: high
    from: F4
  - id: A2
    action: add minimal identity/naming scheme
    target: SCANS.md#Q10.4
    priority: high
    from: F3
  - id: A3
    action: define multipage unit
    target: SCANS.md#Q10.4
    priority: high
    from: F8
  - id: A4
    action: make masking explicit pipeline step
    target: SCANS.md#Q10.4
    priority: high
    from: F1
  - id: A5
    action: add PDF/A verification step
    target: SCANS.md#Q10.2
    priority: med
    from: F9
  - id: A6
    action: define tag storage
    target: SCANS.md#Q10.4
    priority: med
    from: F6
  - id: A7
    action: check backup.sh covers masking-map
    target: meta/backup.sh
    priority: med
    from: F7
  - id: A8
    action: EXIF handling
    target: defer until real scan
    priority: low
    from: F5

notes:
  - accepted: 9
  - rejected: 3
  - A1-A4 form the minimal working basis before first scan.
  - Approach: tighten Q10.4, not add Q10.6+.
