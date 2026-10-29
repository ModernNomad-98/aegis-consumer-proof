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

## Redaction notice

This is the public copy of the owner's SDP-1 record. Source-project identifiers have been
replaced with neutral descriptions under the owner firewall: source pull-request numbers,
approval-register grant ids, and the source repository branch reference. The substitutions
change no policy wording, numbering, date or obligation; each one is listed in the
classification record. Where the owner's text itself quoted an identifier, the quotation is
reproduced with the identifier replaced and marked "(reference redacted)".

The verbatim owner text is retained in a local, non-public owner record outside this
repository. Redaction is **forward-only**: it does not rewrite history. Earlier commits —
the first registration `1e754df7`, the alignment commit `66c602bd`, and `15a83b20` — still
contain the unredacted text, as does the parent tree of this commit.

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
   public consumer repo when pinned to one exact commit SHA on the source repository's main
   branch, with a committed hash manifest, LICENSE and attribution travelling with the
   bytes, and zero edits; divergence is a drift finding, not a local fix.
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
   disable/unpublish), any spend, any action outside the frozen case set, any merge to the
   source repository main branch, U6 publication grant, the parked identity-enforcement PR
   (reference redacted), the capability card.
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
| Public copy | redacted 2026-10-28 under the owner firewall (see the Redaction notice); verbatim text retained locally; unredacted text remains in earlier commits `1e754df7`, `66c602bd` and `15a83b20` |

## 5. Clarification SDP-1a — item 6, merges (dated 2026-10-28)

Same register entry. This is a dated clarification appended to SDP-1, not a second policy
record: no new entry is added to `docs/evidence/index.md`, and items 1, 2, 3, 4, 5 and 7
of section 1 stand exactly as written.

**Source.** Owner clarification, typed by the owner in the owner's own session (chat) on
**2026-10-28 at about 18:20 PDT**, transcribed by the agent that received it, and recorded
in the workspace owner-decision record for SDP-1 dated 2026-10-28. Class: owner
instruction, agent transcription. It is not a GitHub comment and not a provider record.

**The clarification, transcribed.**

1. "Any merge to the source repository main branch" in item 6 means **any merge without an
   ACTIVE approval-register grant**.
2. Merges that cite an **ACTIVE approval-register grant** — that grant, and any later
   grant the owner issues — proceed as before SDP-1: **fresh merger agent, re-derived
   grant scope, hardened preflight, no Lead merge**.
3. **Item 3 is not an exception; it is the normal path.** Item 4 and later work under those
   grants follow the same path without a new ask.
4. **Owner-only remains:** a merge with no grant; a merge whose scope exceeds the cited
   grant; any change to CODEOWNERS / branch protection / auto-merge settings; and anything
   else item 6 already lists.
5. Everything else in SDP-1 and the R-A conditions stands unchanged.

**Reader note (this record's annotation, not the owner's words).** "Item 3" here is the
source project's remediation work item 3 — the merge authorization the owner gave in the
same session for a source-project pull request (reference redacted) under the active
approval-register grant — not item 3 of section 1 of this policy (licensing/vendoring,
U8-class). The clarification says such an authorization is the normal path for a merge
under an active grant, not a special exception to item 6.

**Effect on this repository.** No owner merge concerns
`ModernNomad-98/aegis-consumer-proof`; this repository has no approval register entry, no
approval-register grant and no merge-by-agent path. The clarification is recorded here
because SDP-1 is registered here and the owner asked for it to stay one entry. Item 6's
owner-only remainder is otherwise unchanged: every settings change (including Pages
disable/unpublish), spend, an action outside the frozen case set, the U6 publication grant,
the parked identity-enforcement PR (reference redacted) and the capability card still need
the owner, and so does any merge this clarification does not cover.

| Field | Value |
| --- | --- |
| Clarification | SDP-1a, dated 2026-10-28 |
| Scope | item 6 (merges) only; items 1-5 and 7 unchanged |
| Source class | owner instruction, transcribed from the owner's session message; not a GitHub comment |
| Register entries added | none — this section is part of the SDP-1 entry |
