# I5-REVIEWER — independent review record

**Artifact reviewed:** this directory — the redacted derivative of the Project Aegis Item 5
native-starter evidence export, published at
`docs/evidence/consumer-readiness/exports/item5-20261028/`.

**Builder (disqualified as reviewer):** the Item 5 evidence was produced by a DeepSeek Harness
agent on configured route `deepseek-flash`; the export was packaged by the Item 5 export agent
and this derivative by the AEP3-I5 publication agent. All are in the build chain.

**Reviewer:** a fresh Claude Code headless process started for this review only, in the staged
directory, with no resume and no prior conversation. Model `claude-sonnet-5-5` (Anthropic) —
a different vendor and model from the DeepSeek builder — and not in the build chain. The
reviewer was given only the staged directory path and the review requirement (zero
alias/username bytes, derivative truthfulness, attribution present). It was told to derive the
identifiers from its own machine and to run its own scan rather than trust the publisher's.

Invocation shape (both rounds):

    claude -p "<review brief>" --model claude-sonnet-5-5 --output-format json \
      --session-id <uuid> --permission-mode bypassPermissions \
      --allowedTools "Bash,Read,Glob,Grep" --safe-mode

The full session JSON is retained in the publisher's local evidence
(`item5-publish/evidence/`), with the identifiers redacted for storage.

## Round 1 — 2026-10-29 06:19–06:24 PDT — session `f6eed1e1-0596-4ced-91d7-85e481dfbb84` — FAIL

The reviewer scanned all 85 files (78 under `bundle/`, 7 at the root), in ASCII/Latin-1 and
UTF-16LE, including file paths, for the account name, its six-character stem, the 8.3 alias,
the alias stem and `~1` variants, plus a generic `[A-Za-z0-9_]{1,8}~[0-9]` pattern.
**Identity hits: 0.** It independently reproduced the manifest (78/78), the aggregate hash, the
75 unchanged rows and the 3 changed rows, the byte deltas, the 74+74 masks, and confirmed the
LICENSE/NOTICE. It also reversed the mask in memory with the machine's alias and reproduced
both recorded before-hashes exactly.

It returned **FAIL** on three documentation-accuracy defects — not on any identifier leak:

1. `MANIFEST-DETAIL.tsv` LF/CR columns held the counts of literal `\n`/`\r` text sequences,
   not of LF/CR bytes (systematic; only 12 of 78 rows happened to agree).
2. README stated a 22-byte mask over an 18-byte original; the measured sizes are 21 and 17
   (the +4 bytes per masked line was correct).
3. README pre-asserted a reviewer PASS and linked a record file that did not yet exist.

All three were fixed in the staged bytes: `MANIFEST-DETAIL.tsv` is recomputed from the actual
bytes (for example `bundle/ARTIFACT-MANIFEST.txt` 77 LF / 77 CR, `bundle/STAGE-E-RECORD.md`
264 LF / 0 CR); README now states 21 B / 17 B; and the README review section describes the
gate without asserting a verdict. The derivative evidence bytes were not changed by these
fixes — only the detail manifest and the README, neither of which is a bundle file.

## Round 2 — gating review — 2026-10-29 06:25–06:29 PDT — session `c1071df8-bf76-45a1-a4e2-0d7ec7b572b1` — **PASS**

Fresh process, same model `claude-sonnet-5-5`, new session, no resume, read-only. It derived
five lowercase terms at runtime (account name; its first six characters; the 8.3 alias from two
independent methods; the alias stem; the `~1`/`~` variants) and scanned all **86 files** (78
under `bundle/`, 8 at the root) byte-wise in single-byte and UTF-16LE form, plus all file and
directory names, plus a generic `[A-Za-z0-9_]{1,8}~[0-9]` pattern.

- **Identity hits: 0** for every term, both encodings, names included. A positive control with
  the alias planted in both encodings was detected, so the scanner was shown able to fail.
- **Manifest:** 78/78 verify; covers exactly the 78 bundle files; 8,277 B, SHA-256 `16532a34…`.
- **Aggregate:** `f0e01155…` reproduced from the manifest in ordinal path order.
- **Derivative manifest:** 78 rows; 75 unchanged with before = after = actual; 3 changed with
  after-hash and size matching the actual bytes; totals 310,293 → 310,629 (+336).
- **Mask:** reversing the 21-byte mask to the 17-byte original in memory reproduced both
  recorded before-hashes (`b0e85703…`, `cf5307e7…`) and 55,778 B, 74 occurrences on 74 lines
  each. The `08` before-hash cannot be reproduced because the deleted line is gone; it is
  consistent with the recorded 256-byte delta and 4,320 → 4,064 B.
- **`MANIFEST-DETAIL.tsv`:** bytes, LF, CR and SHA-256 match actual bytes for all 78 files — the
  round-1 defect is fixed.
- **README:** mask 21 B / original 17 B correct; 148 masked lines, 74+74, LICENSE 11,357 B,
  NOTICE 55 B correct; no review outcome asserted.
- **Attribution:** LICENSE is Apache-2.0; NOTICE carries the Project Aegis copyright line.

**Verdict: PASS.** Zero identifier bytes, documentation matches the bytes, attribution present.
Publication proceeded on this verdict; the record above is committed with the derivative.

## Publication gate

The commit is made only after a PASS in round 2. A non-zero identity hit in any round stops
publication; the publisher then fixes the bytes and re-runs a fresh reviewer.
