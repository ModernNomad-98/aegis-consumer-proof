# Owner Standing Decision Policy SDP-1

Owner policy, dated **2026-10-28**. Owner: Peter (`ModernNomad-98`), this repository's
release authority.

**Class.** An owner instruction given in the owner's own session and transcribed verbatim
by the agent that received it. It is not a GitHub comment and not a provider record. The
seven statements in section 1 are the policy; everything around them is this record.

**Source.** Owner session message, 2026-10-28 at about 18:10 PDT, transcribed in the
session that carried the release A readiness record (`docs/evidence/release-readiness/A.md`).
The date on this record is the date the policy was given, not the date of transcription.

**Status.** In force from 2026-10-28 until the owner revises or withdraws it. It changes
when the owner must be asked; it does not change what must be proven.

## 1. Policy

1. **Fail-closed default = adopted.** When a fail-closed default is proposed and the owner
   has not answered within 30 minutes of the STATUS carrying the ask, adopt the default,
   record "adopted by SDP-1 timeout", and continue. Never adopt a non-fail-closed option by
   timeout.
2. **Spec questions (A-series):** answer from the consumer plan's own design statements; if
   explicit, that is the answer; if silent, treat the fail-closed outcome (CP UNRUN, no
   closure claim) as the answer and log the gap as a plan defect. A-13: YES, three-seed on
   cleared storage is expected behavior; prove with CP-06; observed != expected is FAIL.
3. **Licensing/vendoring (U8-class):** YES — Aegis package bytes may be committed to the
   public consumer repo when pinned to one exact Aegis main SHA, with a committed hash
   manifest, LICENSE and attribution travelling with the bytes, and zero edits; divergence
   is a drift finding, not a local fix.
4. **Release steps R-B, R-RB1, R-RB2, R-EMPTY: pre-granted conditionally.** Each may
   dispatch without a new ask when (a) the previous step's evidence report is posted with
   observed values, (b) the committed deploy gate replays PASS at the dispatch commit and
   FAILS CLOSED at the pre-bundle commit, (c) the step is in the frozen case set, and (d)
   prior state is re-observed within 5 minutes of dispatch. If any condition fails: STOP;
   that step reverts to a per-ask decision. A failed dispatch is never retried under this
   grant.
5. **Manual-only owners (U4-class): trigger-scoped standing permission** for
   `ci-pipeline-architect`, `observability-operator`, `agent-authorization-matrix`,
   `playwright-e2e-engineer`, limited to the frozen case set. Each invocation is logged as
   an exact-name human-granted invocation citing SDP-1 and the case id. Any invocation
   outside the case set is a per-ask decision.
6. **Still requires the owner, no exceptions:** any repo settings change (including Pages
   disable/unpublish), any spend, any action outside the frozen case set, any merge to
   Project-Aegis main, U6 publication grant, #943, the capability card.
7. **Evidence rule unchanged:** every pre-granted action produces the same
   observed-evidence report it would have produced under a per-ask grant. SDP-1 removes the
   wait, not the proof.

## 2. Terms this record binds

| Term | What it means here |
| --- | --- |
| The frozen case set | The 22 acceptance cases `CP-01` … `CP-22` frozen for this repository's release procedure. A step or an invocation outside that set is not covered by SDP-1. |
| STATUS carrying the ask | A dated status that states the ask and the proposed fail-closed default, so the 30-minute window in item 1 is measured from a recorded time rather than from memory. |
| Pre-granted action | An action SDP-1 permits without a new ask, which still produces its observed-evidence report (item 7). |
| Steps item 4 covers | `R-B`, `R-RB1`, `R-RB2`, `R-EMPTY`. Release A's publish decision (`R-A`) is not in that list and remains a per-ask decision, as `docs/evidence/release-readiness/A.md` states. |

## 3. What this record does not do

- It does not dispatch, deploy, publish or change any repository setting. Committing it is
  content only. Pages disable/unpublish and every other settings change remain owner-only
  (item 6).
- It does not by itself make a manual-only invocation permitted. Item 5 permits one only
  inside the frozen case set, only when a human types the exact skill name at its turn, and
  only with the consumer-local authority entry written first. No such entry exists in this
  repository and no manual-only invocation has occurred.
- It does not carry the release authorizations, revisions or merges the owner gave in the
  same session for the source project. Those concern another repository and are outside
  this record.

## 4. Record

| Field | Value |
| --- | --- |
| Policy | SDP-1, owner standing decision policy |
| Date | 2026-10-28 |
| Owner | Peter (`ModernNomad-98`) |
| Source class | owner instruction, transcribed from the owner's session message; not a GitHub comment |
| Consumer repository | `ModernNomad-98/aegis-consumer-proof` |
| Registration | `docs/evidence/index.md` carries this file's SHA-256, byte count and LF count |
| Supersedes | no earlier owner policy record in this repository |
