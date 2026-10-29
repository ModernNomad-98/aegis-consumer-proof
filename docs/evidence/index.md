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
| `docs/evidence/release-readiness/B.md` | `be7839d2b7f8d695f57b652ca27ba90034fad288e504af5e83b012db79e50f53` | 14977 | RV-3 readiness record for release B (RP-D-14): the eight required fields, the build run and artifact, known UNRUN, the release A rollback source with deployment `7401326753`, and the authority line stating that deployment requires the SDP-1 item 4 conditions at the dispatch commit plus the owner record. Its §7 D-01 note now records D-01 as **RESOLVED** by the SDP-1b amendment (2026-10-29): SDP-1 item 4 no longer covers R-EMPTY, which is owner-only per item 6 and always a per-ask with the pushed state restated, while A1 §12 E12 remains `NOT GRANTED` and now agrees. |

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
| `docs/evidence/deployments/A.md` | `09703accb7ba2e192ab31e8ae64aee2956638b55c3ce6a7b90a8f9061cd2a7c9` | 13752 | 263 | Release A deployment record: deployment `7401326753` (`github-pages`, `main`, sha `7591c657…`) with status `20870583731` `success`; run `40798505740` `success` with deploy job `123200676832` `success` and build job `123200678387` `skipped`; `environment_url` and HTTP 404 → 200; served bytes byte-identical to the retained bundle and reproducing rows=3 / 251 serialized bytes / aggregate `12ad18e1…`; no Pages build record exposed under `build_type: workflow` (none fabricated); the owner R-A authorization and the irreversibility note. The §2 "Recorded in" cell cites the workspace owner decision record for R-A / A-13 / U8 dated 2026-10-28 by path, 2,256 B and SHA-256 `1c47cf27…`, and states that the record is not committed to this repository (D-02 pointer correction under CP-02=A; this entry was recomputed from the corrected bytes). |

## Owner decisions

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/owner-decisions/SDP-1.md` | `f15ce847138779c5bd00bf6b470f26a2bfd250ae4decd23421019298e98eeb8e` | 13327 | 203 | Owner standing decision policy SDP-1, dated 2026-10-28, recorded as an owner instruction from the owner's session (not a GitHub comment): fail-closed timeout default; spec-question rule and A-13; licensing/vendoring; the conditional pre-grant for release steps R-B, R-RB1 and R-RB2; the trigger-scoped manual-only permission and its invocation log; the remainder that stays owner-only; and the unchanged evidence rule. The same entry also carries the dated **SDP-1a** clarification of item 6 (2026-10-28): any merge to the source repository main branch means a merge without an ACTIVE approval-register grant; a merge citing an active approval-register grant follows the pre-SDP-1 path; item 3 is the normal path, not an exception; the owner-only remainder is unchanged. The same entry also carries the dated **SDP-1b** amendment of item 4 (2026-10-29): R-EMPTY is excluded from the conditional pre-grant and is owner-only per item 6, always a per-ask with the pushed state restated; A1 §12 E12 remains `NOT GRANTED` and now agrees with SDP-1; and D-01 is resolved by that amendment. **Public copy redacted** under the owner firewall; see the redaction note below. |

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

## Consumer readiness

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/consumer-readiness/drift-register.md` | `d4049b7e9c09d541c43baf240de6b9bbd4f386adca4ebfde7890e3a5bc044e0a` | 14527 | 99 | CP-02 drift register against plan A1 §12 (owner decision CP-02=A, 2026-10-29): **D-01 (HIGH)** SDP-1 item 4 pre-granted R-EMPTY on conditions (a)–(d) alone (pre-amendment state), while A1 §12 E12 records R-EMPTY `NOT GRANTED` and plan S25 requires a U7 grant or a recorded irreversible-by-decision acceptance at S24b; **D-02 (MEDIUM)** the release A deployment record's "Recorded in" cell pointed at the R-A request, which is the ask and holds neither the answer nor conditions (a)–(e), with the pointer corrected in `docs/evidence/deployments/A.md` §2; **D-03 (LOW)** SDP-1 item 5 records a trigger-scoped standing permission where A1 §12 E14 records a per-turn, ungranted U4. **D-01 is RESOLVED** by the SDP-1b amendment (2026-10-29): SDP-1 item 4 excludes R-EMPTY, which is owner-only per item 6 and always a per-ask with the pushed state restated, and A1 §12 E12 remains `NOT GRANTED` and now agrees with SDP-1. **D-02** and **D-03** are **recorded — not exercised; not resolved**: the register itself grants nothing and alters no policy, and D-03 remains open for the owner or Lead. |

## Settings changes

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/CP-21-settings-change-20261029/CP-21-SETTINGS-CHANGE-20261029.md` | `bc07e378bc3eebaba5fa9654f2a764af253bc28aa93465210b923a84c7a2be5f` | 15860 | 199 | Owner-authorized (SDP-1 section 1 item 6) settings change, dated 2026-10-29 (CP-21=B, condition (vi); conditions (i)-(vi) binding): the `github-pages` deployment branch policy id `64714655` (`main`) was temporarily supplemented with two exact branch policies, `64824653` `aep3-i2/cp12.7-manifest-symlink` and `64824654` `aep3-i2/cp21-freshness-selector`, added 2026-10-29T17:56:37Z and removed 2026-10-29T17:58:42Z (HTTP 204), **2 min 6 s** under change against a 60-minute limit; four readings (B1 17:55:37Z total_count=1; A1 17:56:38Z total_count=3; A2 17:58:43Z total_count=1 byte-identical to B1; B2 17:58:43Z byte-identical to B1) plus post-run FINAL and SUSTAINED re-reads prove the revert; the temporary admission carried exactly one fail-before dispatch (run `40926181149` success, deployment `7420139651`, served A aggregate `12ad18e1...`), one pass-after refusal (run `40926362502` failure `freshness_selector_refused`, steps 6-8 skipped, no upload or publish, served unchanged), and the restore from `main` (run `40926519791` success, deployment `7420187769`, served B `36bc4407...` byte-identical to the before snapshot); the revert evidence and the run records are attached in the same directory. |

The entry's 29 attached evidence files are bound by
`docs/evidence/CP-21-settings-change-20261029/EVIDENCE-INDEX.md` (5481 B, SHA-256
`9f252ecda4a735771ebb0b137639e4733c22135e619d8194fbcd26838670fe07`), which lists each file's
SHA-256, byte count and LF count over the committed bytes.
