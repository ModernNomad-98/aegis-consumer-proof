# Evidence index

SHA-256 values here are computed over the exact committed bytes (LF endings, no BOM).
An entry binds one file; if that file changes, its entry must be recomputed.
Owner policies and decisions committed to this repository are registered here too, in the
same form as evidence records.

## Release A

| Artifact | SHA-256 | Bytes | Purpose |
| --- | --- | --- | --- |
| `docs/evidence/release-readiness/A.md` | `b1dea6310314c439b39b0f9665a087e3c4a540a0a77c440ec9621ae0ca3cd9c5` | 7613 | RV-3 readiness record for release A (RP-D-14): the eight required fields, known UNRUN, and the authority line stating that deployment requires the owner R-A answer. |

The retained bundle is deliberately not hashed here. `docs/evidence/releases/A/manifest.txt`
already binds the three retained files by byte count, LF count and SHA-256, and the
deploy gate recomputes all of it — per-file digests, LF counts, serialized length and the
aggregate — from the retained bytes on every deploy. Restating those values in this index
would create a second, weaker copy that could drift from the bytes it claims to describe.
The verified aggregate is
`12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` over 3 rows and
251 serialized bytes, as recorded in `docs/evidence/release-readiness/A.md` section 4.

## Deployments

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/deployments/A.md` | `6877c4a4c084bae83044fadbb31b4c80702e065de8c19e1dc631472bc9624f3e` | 13470 | 263 | Release A deployment record: deployment `7401326753` (`github-pages`, `main`, sha `7591c657…`) with status `20870583731` `success`; run `40798505740` `success` with deploy job `123200676832` `success` and build job `123200678387` `skipped`; `environment_url` and HTTP 404 → 200; served bytes byte-identical to the retained bundle and reproducing rows=3 / 251 serialized bytes / aggregate `12ad18e1…`; no Pages build record exposed under `build_type: workflow` (none fabricated); the owner R-A authorization and the irreversibility note. |

## Owner decisions

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/owner-decisions/SDP-1.md` | `5a58d2ad1af3ad952f130341a3bed1df0f078c2a197ed390b0bca96380c15f11` | 7979 | 128 | Owner standing decision policy SDP-1, dated 2026-10-28, recorded as an owner instruction from the owner's session (not a GitHub comment): fail-closed timeout default; spec-question rule and A-13; licensing/vendoring; the conditional pre-grant for release steps R-B, R-RB1, R-RB2 and R-EMPTY; the trigger-scoped manual-only permission and its invocation log; the remainder that stays owner-only; and the unchanged evidence rule. The same entry also carries the dated **SDP-1a** clarification of item 6 (2026-10-28): "any merge to Project-Aegis main" means a merge without an ACTIVE approval-register grant; a merge citing an active grant (APR-140, APR-143 or a later grant) follows the pre-SDP-1 path; item 3 is the normal path, not an exception; the owner-only remainder is unchanged. |
