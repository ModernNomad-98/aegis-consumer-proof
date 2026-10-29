# Evidence index

SHA-256 values here are computed over the exact committed bytes (LF endings, no BOM).
An entry binds one file; if that file changes, its entry must be recomputed.

## Release A

| Artifact | SHA-256 | Bytes | Purpose |
| --- | --- | --- | --- |
| `docs/evidence/release-readiness/A.md` | `377308162f202781fef3c6590441ecf79b6b6c4d88af1d46649c9b5e317c3e2e` | 6605 | RV-3 readiness record for release A (RP-D-14): the eight required fields, known UNRUN, and the authority line stating that deployment requires the owner R-A answer. |

The retained bundle is deliberately not hashed here. `docs/evidence/releases/A/manifest.txt`
already binds the three retained files by byte count, LF count and SHA-256, and the
deploy gate recomputes all of it — per-file digests, LF counts, serialized length and the
aggregate — from the retained bytes on every deploy. Restating those values in this index
would create a second, weaker copy that could drift from the bytes it claims to describe.
The verified aggregate is
`12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` over 3 rows and
251 serialized bytes, as recorded in `docs/evidence/release-readiness/A.md` section 4.
