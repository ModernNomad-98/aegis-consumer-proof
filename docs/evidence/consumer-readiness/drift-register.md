# Drift register — consumer records against A1 §12

**Record type:** consumer drift register. **Status: RECORDED — not exercised, not resolved.** This register is a record, not a policy change: it grants nothing, closes nothing, and supersedes no owner instruction.

**Authority.** Owner decision **CP-02 = A** (2026-10-29), recorded in `_A/work-package-3/OWNER-DECISION-BATCH-ANSWERS-2026-10-29.md` (the file is appended to concurrently, so no stable whole-file digest is claimed here): plan A1 §12 is the authoritative E3 allocation; consumer records are downstream copies, and any divergence is a drift finding against the consumer record. A1 is the Stage-0 record `_A/remediation/handshake/item2-consumer-plan/v4/CONSUMER-STAGE-0-v4.md` (41,024 B, 329 LF, SHA-256 `4de970ee7b4f76055f10cde863a46516483c6ac978de0d54d4b4134ae30d0c26`).

**Scope.** The consumer records at `main` `464542aefad4355562260dccea0ad0c1d0652fdb`; the pre-correction identities in the table are from that commit. Source: the CP-02 reconciliation and findings records in the workspace, `_A/work-package-3/item2-cp02/` — `CP-02-RECONCILIATION.md` (19,420 B, SHA-256 `594252b9f572c68b5035d0a499ffd1458ba0198b2d9873344f82174017dd7c5f`) and `DRIFT-FINDINGS.md` (14,702 B, SHA-256 `4c9c1a7f1b2189020e3519b06246bf9611e3628b242a2221d404d0d9a14326a9`).

## Entries

| ID | Severity | Consumer record | Drift | Status |
| --- | --- | --- | --- | --- |
| D-01 | **HIGH** | `docs/evidence/owner-decisions/SDP-1.md` item 4; registered by `docs/evidence/index.md` | SDP-1 pre-grants R-EMPTY on conditions (a)–(d) alone. A1 §12 E12 records R-EMPTY **NOT GRANTED** with the DELETE-Pages primitive **UNVERIFIED**; plan S25 requires U5 **+ U7 or a recorded irreversible-by-decision acceptance** (disposition at S24b). | **Recorded — not exercised; not resolved.** **OWNER DECISION REQUIRED** — restated below. |
| D-02 | **MEDIUM** | `docs/evidence/deployments/A.md` §2 | The "Recorded in" cell cited the R-A request (`item2-ra/R-A-REQUEST.md`) as recording the R-A answer and conditions (a)–(e); that file is the ask and contains neither. The answer and the full conditions (a)–(e) are recorded in the workspace owner decision record for R-A / A-13 / U8, which is not committed to this repository. | **Recorded — not exercised; not resolved.** The pointer cell is corrected in the same content commit as this register; the finding stays recorded until that commit is merged. |
| D-03 | **LOW** | `docs/evidence/owner-decisions/SDP-1.md` item 5 | SDP-1 records a "trigger-scoped standing permission" for U4-class manual-only owners. A1 §12 E14 records U4 as **NOT GRANTED**, requiring a per-turn human exact-name invocation **and** the consumer-local register entry written first. | **Recorded — not exercised; not resolved.** |

## D-01 — R-EMPTY pre-granted without the U7 precondition (HIGH)

> **OWNER DECISION REQUIRED — D-01 remains OPEN.** This restatement decides nothing and changes no status; it is written so the next STATUS can carry the decision without opening this register.
>
> **What it is —** SDP-1 item 4 pre-grants R-EMPTY on conditions (a)-(d) alone, while A1 §12 E12 records R-EMPTY **NOT GRANTED** — the DELETE-Pages primitive is UNVERIFIED — and plan S25 requires U5 plus **U7 or a recorded irreversible-by-decision acceptance** (disposition at S24b).
>
> **Why HIGH —** followed alone, item 4 authorizes an irreversible teardown or unpublish on four release-step conditions, none of which is the U7 disposition A1 requires; the two records answer the same step oppositely, and the permissive reading is the copy a consumer would follow.
>
> **Options and fail-closed default —** **(A)** amend SDP-1 item 4 to carve out R-EMPTY and require an S24b disposition before dispatch, closing D-01 as resolved; **(B)** record precedence without editing SDP-1 — A1 §12 E12 controls, and item 4 grants nothing for R-EMPTY until a disposition exists — closing D-01 as resolved by recorded precedence; **(C)** take no action — the **fail-closed default if the owner does not answer**: D-01 stays OPEN, R-EMPTY stays NOT GRANTED, and no R-EMPTY, teardown or unpublish may proceed on item 4 alone.

**Evidence.**

- `docs/evidence/owner-decisions/SDP-1.md` — 9,321 B, 146 LF, SHA-256 `5a84295101890bfee134e094b76d0e584435944f8c7b633a8ae8aa1446708894`: item 4 (lines 45–49) lists R-B, R-RB1, R-RB2 and R-EMPTY as "pre-granted conditionally" on (a) prior report posted, (b) deploy gate PASS at dispatch and FAIL-CLOSED at pre-bundle, (c) step in the frozen case set, (d) prior state re-observed within 5 minutes.
- `docs/evidence/index.md` — 6,036 B, 66 LF, SHA-256 `c9e56be32d7d0208b6964639703667047315ec6769d0125797ea53b10d26e02a` (at `464542ae`): line 48 registers SDP-1 as carrying "the conditional pre-grant for release steps R-B, R-RB1, R-RB2 and R-EMPTY". (The finding's original scope at `390363f` recorded the same row in a 4,804 B file, SHA-256 `2a2fe064183c0829b5b74d25852927d2c03decd94fc1126cdc309dc41232220f`.)
- A1 §12 E12: "`R-EMPTY` (U5) | `NOT GRANTED`; provider primitive also UNVERIFIED". A1 §13 U7: owner grant to create/delete a disposable repository, **or** a recorded "irreversible by decision" acceptance, **or** the owner's recorded "keep it" decision — "OPEN — not granted; a new owner decision".

**Why this is drift.** SDP-1's four conditions are release-step conditions. None is U7, an irreversible-by-decision acceptance, or a "keep it" decision, and none verifies the DELETE-Pages primitive. Read alone, item 4 says R-EMPTY may be dispatched on (a)–(d); A1 §12 and plan S25 say it may not be dispatched until a U7 disposition exists.

**Effect taken: none.** No R-EMPTY ask, teardown, delete or unpublish; all four deployments remain.

**Required note for any future ask.** A future R-EMPTY / teardown ask must carry an **S24b disposition** — a U7 disposable-repository grant, a recorded irreversible-by-decision acceptance, or the owner's recorded "keep it" decision — **in addition to** SDP-1 item 4. Item 4 does not supply that disposition.

## D-02 — release A deployment record pointed at the ask, not the grant (MEDIUM)

**Evidence.**

- `docs/evidence/deployments/A.md` at `464542ae` — 13,470 B, 263 LF, SHA-256 `6877c4a4c084bae83044fadbb31b4c80702e065de8c19e1dc631472bc9624f3e`: §2, "Recorded in" cell (line 35).
- The cited request `item2-ra/R-A-REQUEST.md` — 6,969 B, 139 LF, SHA-256 `774266e84d841efc572e505778b41c2f6bbddbbf9192018ad3549afe7642be7a`; a workspace-only document whose own header says it is not committed to the consumer repository, and the ask: it contains no owner answer, no conditions (a)–(e), and no E3-inference statement.
- The actual source `_A/remediation/handshake/OWNER-DECISION-RA-A13-U8-2026-10-28.md` — 2,256 B, 25 LF, SHA-256 `1c47cf274ccde5cfd2c0650605b9eabb1c7b8ac1b70053c6955961a68499969d`: records R-A YES, one dispatch, and conditions (a)–(e). It is workspace-local and **not committed to this repository**.

**Why this is drift.** A verifier following the consumer record to the request finds the ask, not the grant, and cannot verify conditions (a)–(e) from any committed byte. The finding concerns the pointer, not the authority: deployment `7401326753` was taken under a genuine per-ask owner grant.

**Effect taken: deployment A, under the genuine grant.** The drift did not authorize anything.

**Correction.** In the same content commit as this register, the A.md §2 "Recorded in" cell now cites the workspace owner decision record by path, byte count and SHA-256, and states that the record is not committed to this repository. No other cell or section of A.md changes.

## D-03 — U4 recorded as trigger-scoped standing permission (LOW)

**Evidence.**

- `docs/evidence/owner-decisions/SDP-1.md` — 9,321 B, SHA-256 `5a84295101890bfee134e094b76d0e584435944f8c7b633a8ae8aa1446708894`: item 5 (lines 52–56) records "**Manual-only owners (U4-class): trigger-scoped standing permission**" for four named skills within the frozen case set, each invocation logged as an exact-name human-granted invocation. §3 (lines 79–82) preserves the gate and records that no consumer-local authority entry exists and no manual-only invocation has occurred.
- A1 §12 E14: "`U4` — per-turn human exact-name invocation + consumer-local register entry written first | `NOT GRANTED`"; exclusion: "standing permission; a copy is not an invocation". A1 §13 U4: "OPEN — not granted".

**Why this is drift.** The shape of the authority differs: A1 records a per-turn, ungranted U4; SDP-1 records a scoped standing permission. SDP-1 §3 preserves the per-turn gate, and no invocation was taken, so the severity is LOW — but the state statement diverges and is recorded.

**Effect taken: none.** No manual-only invocation; no consumer-local authority entry exists.

**Required precedence note.** **A1 §12 E14 controls the U4 per-turn gate.** SDP-1 item 5 does not widen it: a manual-only invocation still requires a human typing the exact skill name at its turn, with the consumer-local authority entry written first. SDP-1 item 5 records a scoped permission shape; it does not convert U4 into a standing grant that bypasses the per-turn gate.

## Precedence notes (explicit)

1. **R-EMPTY / teardown.** No future R-EMPTY or teardown ask may proceed on SDP-1 item 4 alone. It must carry an **S24b disposition** (U7 grant, recorded irreversible-by-decision acceptance, or recorded "keep it" decision).
2. **U4 manual-only.** **A1 §12 E14 controls**; **SDP-1 item 5 does not widen** the per-turn gate. The exact-name human invocation and the prior consumer-local register entry remain required.

## Evidence identities

| Item | Bytes | LF | SHA-256 |
| --- | ---: | ---: | --- |
| A1 Stage-0 record §12 | 41,024 | 329 | `4de970ee7b4f76055f10cde863a46516483c6ac978de0d54d4b4134ae30d0c26` |
| `docs/evidence/owner-decisions/SDP-1.md` | 9,321 | 146 | `5a84295101890bfee134e094b76d0e584435944f8c7b633a8ae8aa1446708894` |
| `docs/evidence/index.md` at `464542ae` | 6,036 | 66 | `c9e56be32d7d0208b6964639703667047315ec6769d0125797ea53b10d26e02a` |
| `docs/evidence/deployments/A.md` at `464542ae` | 13,470 | 263 | `6877c4a4c084bae83044fadbb31b4c80702e065de8c19e1dc631472bc9624f3e` |
| R-A request as cited (`item2-ra/R-A-REQUEST.md`) | 6,969 | 139 | `774266e84d841efc572e505778b41c2f6bbddbbf9192018ad3549afe7642be7a` |
| Workspace owner decision record R-A / A-13 / U8 | 2,256 | 25 | `1c47cf274ccde5cfd2c0650605b9eabb1c7b8ac1b70053c6955961a68499969d` |
| Source findings `DRIFT-FINDINGS.md` | 14,702 | 214 | `4c9c1a7f1b2189020e3519b06246bf9611e3628b242a2221d404d0d9a14326a9` |
| Source `CP-02-RECONCILIATION.md` | 19,420 | 215 | `594252b9f572c68b5035d0a499ffd1458ba0198b2d9873344f82174017dd7c5f` |

## What this register does not do

- It does not change policy, grant authority, or resolve D-01/D-03; those remain owner/Lead decisions.
- It does not edit SDP-1, `index.md`, the workflow, the site, or any setting.
- It does not claim that any drifted reading was exercised: no R-EMPTY, no teardown, no manual-only invocation, and no deployment took effect under a drifted reading.
- It records D-02's pointer correction in A.md §2; the correction is content-only and has no deploy effect.

**Index note.** `docs/evidence/index.md` still binds `docs/evidence/deployments/A.md` at its pre-correction digest `6877c4a4…` and does not list this register. Recompute that entry when this content commit is merged; this commit's scope is the A.md pointer cell plus this register.
