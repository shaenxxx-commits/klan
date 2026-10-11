# SYNTHESIS run4
# Author: lead (KLAN)
# Status: synthesis, not source transcript

meta:
  run_date: 2026-10-11
  synthesis_date: 2026-10-11
  head: 20b9615
  sources:
    - 2026-10-11-gpt-6-run4.md
    - 2026-10-11-kimi-k2-thinking-run4.md
    - 2026-10-11-qwen3.7-run4.md
  question_set: [a, b, c, d]

channel:
  - node: gpt-6
    access: OK
    calibration:
      change_vs_run3: stable
      strong: precise code review, accurate citations
      weak: none in this run
  - node: kimi
    access: OK (claimed)
    calibration:
      change_vs_run3: REGRESSION (confabulation returned)
      strong: none
      weak: invented paths (D:\\KLAN-DropZone), invented
            script lines (quarantine, RANDOM), invented
            Q-numbers (Q10.7-Q10.9)
  - node: qwen
    access: OK (claimed)
    calibration:
      change_vs_run3: REGRESSION (confabulation)
      strong: none
      weak: claimed trap/mount_rw/init missing in
            import-scan.sh (all present); cited run3
            finding F4 as current (closed in A1)

accepted:
  - id: F1
    finding: multipage unit not implemented in import-scan.sh
    evidence: [SCANS.md#Q10.4, import-scan.sh]
    sources: [gpt-6]
  - id: F2
    finding: import handles only png/jpg/jpeg; PDF/TIFF dropped silently
    evidence: [import-scan.sh, SCANS.md#Q10.2]
    sources: [gpt-6]
  - id: F3
    finding: mtime used as scan-date surrogate
    evidence: [SCANS.md#Q10.4, import-scan.sh]
    sources: [gpt-6, qwen]
  - id: F4
    finding: no verification /mnt/shared is the expected NTFS
    evidence: [import-scan.sh]
    sources: [gpt-6]
  - id: F5
    finding: no file-readiness check before copy
    evidence: [import-scan.sh]
    sources: [gpt-6]
  - id: F6
    finding: cp --preserve=mode bypasses 750/640 policy
    evidence: [import-scan.sh, handoff-current.md]
    sources: [gpt-6]
  - id: F7
    finding: --dry-run still remounts via trap cleanup
    evidence: [import-scan.sh]
    sources: [gpt-6]
    severity: critical
  - id: F8
    finding: partial copy leaves orphan ID directory
    evidence: [import-scan.sh]
    sources: [gpt-6]
  - id: F9
    finding: size check is not integrity check (no checksum)
    evidence: [import-scan.sh]
    sources: [gpt-6, qwen]
  - id: F10
    finding: NNN 3-digit limit not enforced (no fail after 999)
    evidence: [SCANS.md#Q10.4, import-scan.sh]
    sources: [gpt-6]
  - id: F11
    finding: mv to .imported can overwrite on name collision
    evidence: [import-scan.sh]
    sources: [gpt-6]
    severity: critical
  - id: F12
    finding: mount errors not exposed as distinct state
    evidence: [import-scan.sh]
    sources: [gpt-6]
  - id: F13
    finding: empty inbox exits as success (processed=0)
    evidence: [import-scan.sh]
    sources: [gpt-6]
  - id: F14
    finding: unknown args not rejected
    evidence: [import-scan.sh]
    sources: [gpt-6]
  - id: F15
    finding: Windows system/temp files not filtered
    evidence: [import-scan.sh]
    sources: [kimi]

rejected:
  - id: R1
    claim: import-scan.sh lacks trap / mount_rw function
    reason: both present (import-scan.sh lines 40-53)
    source: [qwen#a, qwen#b]
  - id: R2
    claim: import-scan.sh lacks variable initialization
    reason: LCH/MNT/INBOX/IMPORTED/ORIGINALS/CLASSES all set at top
    source: [qwen#a]
  - id: R3
    claim: Q9 status still contradictory (F4 from run3)
    reason: reconciled in A1 (commit ca4d96c)
    source: [qwen#g]
  - id: R4
    claim: SCANNING-SETUP.md references D:\\KLAN-DropZone
    reason: file specifies S:\\KLAN\\scan-inbox
    source: [kimi#a]
  - id: R5
    claim: import-scan.sh uses quarantine dir
    reason: no quarantine step in current script
    source: [kimi#b]
  - id: R6
    claim: import-scan.sh ID is ${TIMESTAMP}-${RANDOM}
    reason: uses YYYYMMDD-<class>-<NNN>
    source: [kimi#b]
  - id: R7
    claim: import-scan.sh has interactive read -p prompt
    reason: no such prompt; loops over CLASSES array
    source: [kimi#b]
  - id: R8
    claim: SCANS.md Q10.4 specifies verapdf
    reason: no verapdf mention in current file
    source: [kimi#b]
  - id: R9
    claim: open-questions.md has Q10.7/Q10.8/Q10.9
    reason: Q10 closed; no such subquestions exist
    source: [kimi#g]

action_queue:
  - id: A1
    action: fix --dry-run to not touch mount state
    target: import-scan.sh
    priority: high
    from: F7
  - id: A2
    action: collision-safe mv to .imported
    target: import-scan.sh
    priority: high
    from: F11
  - id: A3
    action: add checksum verification (sha256) to copy
    target: import-scan.sh
    priority: high
    from: F9
  - id: A4
    action: drop --preserve=mode; chmod 640 explicitly
    target: import-scan.sh
    priority: high
    from: F6
  - id: A5
    action: add /mnt/shared source verification (mountpoint + UUID)
    target: import-scan.sh
    priority: med
    from: F4
  - id: A6
    action: file-readiness check (size stable over 2s)
    target: import-scan.sh
    priority: med
    from: F5
  - id: A7
    action: harden script — validate args, filter system files, empty-inbox warning, orphan cleanup, mount-error state
    target: import-scan.sh
    priority: med
    from: [F8, F12, F13, F14, F15]
  - id: A8
    action: multipage import strategy
    target: import-scan.sh + SCANS.md
    priority: high (before first multipage scan)
    from: F1
  - id: A9
    action: enforce NNN <= 999
    target: import-scan.sh
    priority: low
    from: F10
  - id: A10
    action: pre-first-scan checklist (from gpt-6 §g)
    target: meta/handoff-current.md
    priority: high
    from: [F1, F4, F5, F6, F7, F9, F11]

notes:
  accepted: 15
  rejected: 9
  key_finding: >-
    node reliability diverged in run4. GPT-6 clean;
    Kimi and Qwen both regressed to confabulation.
    Only GPT-6 is usable for detailed code review.
    Kimi/Qwen still useful for high-level structural
    audit (as in run3).
  critical_script_defects: >-
    A1 (dry-run remount), A2 (mv overwrite).
    Must fix before first real scan.
  a8_multipage: >-
    architectural — required before first multipage
    document, not blocking single-page test.
  approach: >-
    fix import-scan.sh (A1-A7, A9), then pre-scan
    test. A8 (multipage) can be deferred until first
    multipage document is planned.
