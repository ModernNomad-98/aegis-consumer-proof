# Item 5 export — redacted derivative (published 2026-10-29)

**This directory is a derivative, not the original export.** It republishes the Project Aegis
Item 5 native-starter evidence produced on 2026-10-28 with two classes of local identifier
masked. The original bundle was 78 files / 310,293 B; this derivative is 78 files / 310,629 B.
Three files differ; the other 75 are byte-identical.

Published path: `docs/evidence/consumer-readiness/exports/item5-20261028/` in
`ModernNomad-98/aegis-consumer-proof`, by a normal content commit on `main`. No merge to the
source repository, no deploy, no workflow, secret or repository-settings change was made.

## Why this is a derivative

The original export embedded the local Windows account name that produced the evidence, in
two forms:

1. **The full account name**, on one line of one log, together with an unrelated local
   project path. This line was the subject of the earlier, explicit owner authorization and
   is **deleted** in this derivative.
2. **The 8.3 short-name alias of the same account**, used as the temp-directory prefix on
   **148 lines across two test logs** (74 lines in `10-tests-precommit.log`, 74 in
   `14-tests-final.log`). Publishing the export with only the first line removed would ship
   the operator's account alias 148 times in an artifact advertised as redacted.

The owner directed publication of this derivative and the masking of the second class
(I5 = A, 2026-10-29; the earlier relayed authorization is reply `6486405242`). Both records
are held in the Project Aegis evidence set. The account name and its alias are deliberately
not written anywhere in this directory, including in this README.

## What changed

| File | Change | Bytes before → after | SHA-256 before → after |
| --- | --- | ---: | --- |
| `bundle/raw/logs/08-authority-reading.log` | line 1 deleted (256 B: full account name + unrelated project path); 26 → 25 lines | 4,320 → 4,064 | `f6e632e3aea1bde2ad97ffbf77f665ab3469d46b489feb8b66bed9a4ede0c44a` → `ab086a8624f1ac340575685d996aa5f06477f5f40d744fbfded53081252f7568` |
| `bundle/raw/logs/10-tests-precommit.log` | 74 occurrences on 74 lines replaced with the constant `C:\Users\<redacted>~1` | 55,778 → 56,074 | `b0e857038ad3ee4fb71e780109fcb0d9e9b20b4d9525ffec6a966259e359f4b0` → `d56dc7debac77fce17e09668180517e6e4495f5743676f576ee62fdf6c22a3b8` |
| `bundle/raw/logs/14-tests-final.log` | 74 occurrences on 74 lines replaced with the constant `C:\Users\<redacted>~1` | 55,778 → 56,074 | `cf5307e7b0c1b5298a64c3d62961b9079295ee990a44041a12266018ca199e3a` → `863e757946c8f66af965a16c75d02cd1fcef77a32ee45588bdbf33d3509bcf8d` |

Net bytes: −256 + 592 = **+336** → 310,629 B. Masked occurrences: **148** on **148** lines.
The mask is a fixed 21-byte constant (4 B longer than the 17-byte original), so each masked
line grows by 4 B; no characters are added or removed elsewhere and no line is dropped. The
logs remain truthful run logs — the masked text was a temp-root path prefix, not test output.

No other byte changed. Per-file before/after SHA-256 for all 78 files, and the per-file change
note: [DERIVATIVE-MANIFEST.tsv](DERIVATIVE-MANIFEST.tsv).

## Integrity — how to verify

`manifest.sha256` (8,277 B, SHA-256 `16532a341019c568fe9e8d2f54102283eebb6ba34b5538be46c0d2fa19b04f6c`)
binds all 78 files under `bundle/`; `MANIFEST-DETAIL.tsv` adds each file's byte, LF and CR
counts.

    # from this directory (POSIX shell / Git Bash)
    sha256sum -c manifest.sha256        # expect 78 OK

    # PowerShell equivalent
    Get-Content manifest.sha256 | ForEach-Object { $h,$p = $_ -split '  ',2;
      if ((Get-FileHash $p -Algorithm SHA256).Hash -ne $h.ToUpper()) { "FAIL $p" } } # expect no output

Derivative tree aggregate (SHA-256 over the concatenated per-file digests in ascending path
order): `f0e011555650ed33daf5b02ee47cc5145a48f28b5bc024f03799136b26076180`.

The **original** export had a 310,293 B bundle and a manifest whose SHA-256 was
`c06dc7fa8935042741a5e5579482019c4f8a0e60128f04cf3dca144c8a673053`. Neither value describes
this derivative and neither must be used to check it.

`bundle/ARTIFACT-MANIFEST.txt` is the original in-bundle artifact list, retained verbatim as
part of the evidence bytes; it records the pre-redaction hashes of the three changed files.
For this derivative the authoritative manifest is `manifest.sha256` at this directory's root.

## Attribution — Apache-2.0 preserved

`LICENSE` (11,357 B, Apache License 2.0) and `NOTICE` (55 B) are included at this directory's
root **verbatim and unchanged** from the Project Aegis repository. NOTICE reads:

    Project Aegis
    Copyright 2026 The Project Aegis Authors

This is a modified redistribution of the evidence; the Apache-2.0 attribution is retained in
full and is not stripped. Apache-2.0 §6 grants no trademark rights: "Project Aegis" and
"Zero Trust AI Engineering Discipline" remain the owner's marks, and nothing here implies
endorsement. The evidence's own model attribution is unchanged: the item was produced by a
DeepSeek Harness agent on configured route `deepseek-flash` and read back in a fresh-context
Claude Code session; the serving models were not observable and no serving-model claim is made.

## Provenance of the underlying evidence

| Identity | Commit | Tree |
| --- | --- | --- |
| Installation content pin (41 installed files) | `ffb040c7a363648856475280646bbd142dfabe4e` | `88a5aee4ad928a49c2fb945032585843ec652da7` |
| Documentation baseline (work-item main reference) | `482ba165a790c3a172d00771fa23474764dd916e` | `c8a251e21189aeb7ffb7621e380469a34f5a1f42` |
| Stage E commit | `3a504c83827be462d35f8b1a632e80bf5be46a52` | `c8a251e21189aeb7ffb7621e380469a34f5a1f42` |
| Validated candidate | `750767b731820782e1c1535230a2ef3b78ec4ea7` | — |

`482ba165` is the package baseline, not asserted to be the current tip of the source project.

## Independent review

Publication of this directory is gated on independent review before commit. The reviewer,
designated **I5-REVIEWER**, is a fresh agent session that did not build the export: a separate
Claude Code process, a different vendor and model from the DeepSeek builder, and not in the
build chain. It derives the local identifiers from its own machine and runs its own scan rather
than trusting these manifests, and it checks that this README and `DERIVATIVE-MANIFEST.tsv`
describe the bytes accurately and that the Apache-2.0 attribution is present. Its session
identity, commands and results are recorded in `I5-REVIEWER-RECORD.md`, committed in the same
commit as this directory.

## Scope

Content commit only: no merge to Project Aegis, no deployment, no workflow or repository
setting change. The published tree is the derivative; the original, unredacted export is not
part of this repository.
