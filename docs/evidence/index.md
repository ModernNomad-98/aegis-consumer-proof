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

## Release B

| Artifact | SHA-256 | Bytes | Purpose |
| --- | --- | --- | --- |
| `docs/evidence/release-readiness/B.md` | `5cf82dfcbfa6a9f81ce138bcbfd9dc89b6810151489ae30de5d2067d23e36b9e` | 12184 | RV-3 readiness record for release B (RP-D-14): the eight required fields, the build run and artifact, known UNRUN, the release A rollback source with deployment `7401326753`, and the authority line stating that deployment requires the SDP-1 item 4 conditions at the dispatch commit plus the owner record. |

The retained bundle is deliberately not hashed here. `docs/evidence/releases/B/manifest.txt`
already binds the three retained files by byte count, LF count and SHA-256, and the
deploy gate recomputes all of it — per-file digests, LF counts, serialized length and the
aggregate — from the retained bytes on every deploy. Restating those values in this index
would create a second, weaker copy that could drift from the bytes it claims to describe.
The verified aggregate is
`36bc4407514265db0bd0fcaa9dde87ad2db18373ed5646fd178ec97af5a9ba4a` over 3 rows and
251 serialized bytes, as recorded in `docs/evidence/release-readiness/B.md` section 4.

## Deployments

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/deployments/A.md` | `6877c4a4c084bae83044fadbb31b4c80702e065de8c19e1dc631472bc9624f3e` | 13470 | 263 | Release A deployment record: deployment `7401326753` (`github-pages`, `main`, sha `7591c657…`) with status `20870583731` `success`; run `40798505740` `success` with deploy job `123200676832` `success` and build job `123200678387` `skipped`; `environment_url` and HTTP 404 → 200; served bytes byte-identical to the retained bundle and reproducing rows=3 / 251 serialized bytes / aggregate `12ad18e1…`; no Pages build record exposed under `build_type: workflow` (none fabricated); the owner R-A authorization and the irreversibility note. |

## Owner decisions

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/owner-decisions/SDP-1.md` | `5a84295101890bfee134e094b76d0e584435944f8c7b633a8ae8aa1446708894` | 9321 | 146 | Owner standing decision policy SDP-1, dated 2026-10-28, recorded as an owner instruction from the owner's session (not a GitHub comment): fail-closed timeout default; spec-question rule and A-13; licensing/vendoring; the conditional pre-grant for release steps R-B, R-RB1, R-RB2 and R-EMPTY; the trigger-scoped manual-only permission and its invocation log; the remainder that stays owner-only; and the unchanged evidence rule. The same entry also carries the dated **SDP-1a** clarification of item 6 (2026-10-28): any merge to the source repository main branch means a merge without an ACTIVE approval-register grant; a merge citing an active approval-register grant follows the pre-SDP-1 path; item 3 is the normal path, not an exception; the owner-only remainder is unchanged. **Public copy redacted** under the owner firewall; see the redaction note below. |

**Redaction note.** This row registers the public, redacted copy of SDP-1. Source-project
identifiers (source pull-request numbers, approval-register grant ids and the source
repository branch reference) were replaced with neutral descriptions; the file's own
Redaction notice lists the categories. The verbatim owner text is retained in a local,
non-public record. Redaction is forward-only: the unredacted text remains in earlier commits
`1e754df7`, `66c602bd` and `15a83b20`.

## Exports

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/consumer-readiness/exports/item5-20261028/README.md` | `972f27299a193b673633c9e7af5fa38222fff4e56dca7eb3d683c585bb1ad0d8` | 6830 | 111 | Project Aegis Item 5 native-starter evidence (2026-10-28), published as a **redacted derivative**: the log line carrying the local account name and an unrelated local project path is deleted, and the account's 8.3 short-name alias is masked with a constant on 148 lines across two test logs. 78 evidence files, 310,293 to 310,629 B, 3 files changed and 75 byte-identical, manifest rebuilt; Apache-2.0 LICENSE and NOTICE included verbatim; a fresh independent I5-REVIEWER session (Claude Code, a different vendor and model from the DeepSeek builder) verified zero identifier bytes before commit. |

The 78-file bundle is bound by `docs/evidence/consumer-readiness/exports/item5-20261028/manifest.sha256` (8,277 B, SHA-256
`16532a341019c568fe9e8d2f54102283eebb6ba34b5538be46c0d2fa19b04f6c`) and, file by file, by
`DERIVATIVE-MANIFEST.tsv` with before/after digests. Those per-file values are deliberately not
restated here, for the reason given above; the row above binds the README only.
