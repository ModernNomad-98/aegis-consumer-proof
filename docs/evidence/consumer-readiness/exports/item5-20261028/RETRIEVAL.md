# Retrieval and verification — Item 5 redacted derivative

This directory is a redacted derivative of the Project Aegis Item 5 evidence bundle; it is
not the original export. The README states what was masked and why. Everything needed to
verify the bytes is inside this directory; no archive, sidecar or external tool is required.

## 1. Obtain

    git clone https://github.com/ModernNomad-98/aegis-consumer-proof.git
    cd aegis-consumer-proof/docs/evidence/consumer-readiness/exports/item5-20261028

The publication is a normal content commit on `main`. The commit identity is recorded in the
Project Aegis publication record (I5, 2026-10-29) and in the commit message itself.

## 2. Verify the 78 evidence files

    sha256sum -c manifest.sha256     # 78 lines; expect 78 OK

PowerShell:

    Get-Content manifest.sha256 | ForEach-Object { $h,$p = $_ -split '  ',2;
      if ((Get-FileHash $p -Algorithm SHA256).Hash -ne $h.ToUpper()) { "FAIL $p" } }

Expected derivative aggregate (SHA-256 over the concatenated per-file digests in ascending
path order): `f0e011555650ed33daf5b02ee47cc5145a48f28b5bc024f03799136b26076180`.
`MANIFEST-DETAIL.tsv` carries the byte, LF and CR counts for each file.

## 3. Confirm the redaction

- `bundle/raw/logs/08-authority-reading.log` has 25 lines and SHA-256
  `ab086a8624f1ac340575685d996aa5f06477f5f40d744fbfded53081252f7568`.
- `10-tests-precommit.log` and `14-tests-final.log` contain no local account identifier;
  every former temp-root prefix reads `C:\Users\<redacted>~1`. Each is 56,074 B.
- A case-insensitive search of every file in this directory for the local Windows account
  name, its 6-character stem and its `~1` short alias returns **no matches**. The name is
  intentionally not written here; derive it from the machine you are checking.
- `DERIVATIVE-MANIFEST.tsv` lists before/after SHA-256 for all 78 files; the 75 files not
  listed as changed are byte-identical to the pre-publication bundle.

## 4. Inspect

Start at `README.md`, then `DERIVATIVE-MANIFEST.tsv` (what changed, file by file), then
`bundle/STAGE-E-RECORD.md` and `bundle/V2-EVIDENCE-RECORD.md` (what the evidence run did).
`bundle/ARTIFACT-MANIFEST.txt` is the original in-bundle list and records pre-redaction
hashes; it is historical, not the manifest of this derivative.

## 5. Attribution

`LICENSE` (Apache License 2.0, 11,357 B) and `NOTICE` (55 B) are included verbatim. Read them
with the evidence; do not redistribute the evidence without them.
