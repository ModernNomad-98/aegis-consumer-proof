# Vendored Project Aegis installed starter - pin `ffb040c7`

What this is: a byte-identical copy of the 41-file installed starter package that
Project Aegis publishes at commit `ffb040c7a363648856475280646bbd142dfabe4e`, committed into this repository
so that consumer acceptance rows can be observed against the installed bytes from
inside the public repository.

What this is not: it is not this product's application source, and it is not a
second, editable copy of the guidance. A workspace carrying these files must still
determine its own role from its own evidence (see `AGENTS.md` in this directory).
The application lives in `site/`, and publication comes from `site/` only,
never from this directory.

## Verify the copy

From the repository root:

    cd docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7
    sha256sum HASH-MANIFEST.tsv

Expected: `fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699`

That single hash is the aggregate the source project publishes for this package,
because `HASH-MANIFEST.tsv` is exactly the serialisation the aggregate is defined
over: `path` TAB `bytes` TAB `lf` TAB `sha256` LF, ordinal order, UTF-8 no BOM.
For per-file verification, recompute each row's SHA-256 over the file's bytes and
compare; `HASH-MANIFEST.md` carries the same 41 rows in table form.

## Rules that apply to the files in this directory

* **No edits.** The copied bytes are unmodified. A mismatch is a drift finding to
  be reported and decided, never patched in place.
* **The pin is the identity.** If the source project moves, this directory does not
  follow. A new pin gets a new directory; this one is retained.
* **Attribution travels.** `LICENSE` and `NOTICE` ship with the bytes and are not
  removable while the bytes are here.
* **Contents:** the 41 copied files (`AGENTS.md`, `CLAUDE.md`, `.claude/skills/**`),
  `LICENSE` and `NOTICE` (copied bytes / attribution), and the two manifest files
  plus this note (control files, authored here).
