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

## Owner decisions

| Artifact | SHA-256 | Bytes | LF | Purpose |
| --- | --- | --- | --- | --- |
| `docs/evidence/owner-decisions/SDP-1.md` | `709171edcc76d254367f9378e67fd08d4ae1a11a9f6c2c2a2a9a1b4e5d8e6f78` | 5205 | 82 | Owner standing decision policy SDP-1, dated 2026-10-28, recorded as an owner instruction from the owner's session (not a GitHub comment): fail-closed timeout default; spec-question rule and A-13; licensing/vendoring; the conditional pre-grant for release steps R-B, R-RB1, R-RB2 and R-EMPTY; the trigger-scoped manual-only permission and its invocation log; the remainder that stays owner-only; and the unchanged evidence rule. |
