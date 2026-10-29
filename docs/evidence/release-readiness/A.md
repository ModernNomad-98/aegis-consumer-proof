# Release A — RV-3 readiness record

Plan reference: RP-D-14. Release: A. Repository: ModernNomad-98/aegis-consumer-proof.

Status: **content gates PASS; deployment NOT dispatched; nothing is live.**

This record states what has been proven by execution and what remains UNRUN. It does
not authorize a deployment. See the authority line in section 8.

## 1. Purpose (owner-visible)

The checklist page for release A is fully assembled, byte-verified, and retained inside
this repository at the exact path the deploy gate reads. Everything that can be checked
without publishing has been checked and passes. What is left is a single publish action
that changes live state, and that action needs the owner's R-A answer first.

If the owner answers R-A "authorize", the next step is one manual dispatch of the
existing workflow in deploy mode. If the owner does not answer, nothing happens: the
repository stays as it is and the site stays unpublished.

## 2. Candidate identity

| Item | Value |
| --- | --- |
| Candidate commit (the build that was retained) | `8c5eaf0f4b852cc7456d0a69b4cf08fd241126f3` |
| Candidate tree | `0450a0f055d7b80448bca2824e3ad9273eab6002` |
| Workflow blob (`.github/workflows/pages.yml`) | `927bad72e9803a913dd71bb365311912449f1614` |
| Retained-bundle commit (adds the bundle, no site change) | `5fcea3c2bda66ed9beedec82d09a7f953e6a69cc` |
| Retained-bundle tree | `004025049a15e48869255c90082c9b79b118f40f` |

The three retained files are byte-identical to the committed `site/` at the candidate
commit. Retaining them changed no published byte; it only made the bytes reachable at
the path the gate requires.

## 3. Build run and artifact

| Item | Value |
| --- | --- |
| Workflow run id | `40794805183` |
| Run event / mode | `workflow_dispatch`, mode=`build` (assemble and retain only) |
| Run conclusion | `success` |
| Artifact id | `12863007897` |
| Artifact name | `github-pages` |
| Artifact size | `4975` bytes |
| Artifact digest | `sha256:04862f520ffb014398f4858257ec2336e67ffbb4a4961b0656a1c87b9c273796` |

The downloaded artifact was verified before use: byte size 4975 and SHA-256
`04862f52…c273796` both matched the provider metadata exactly. The artifact contains
`artifact.tar`, whose entries are exactly `./app.js`, `./index.html`, `./styles.css`.

## 4. Manifest aggregate

`docs/evidence/releases/A/manifest.txt` — three TAB-separated data rows in
byte-sorted name order (name, bytes, LF count, SHA-256) plus one aggregate comment.
Format and filename follow the committed gate and the README; the gate reads
`manifest.txt`.

| File | Bytes | LF count | SHA-256 |
| --- | --- | --- | --- |
| `app.js` | 11072 | 427 | `e4e970ff10ccd42d5c868193f59d3e7222d565ad1c96bff3e32843e410906281` |
| `index.html` | 1595 | 40 | `e2e1ceecb84981c248aadbcec1650b1f0e1a468ed308640cb03e64bc6bd5b8f8` |
| `styles.css` | 3860 | 247 | `1874ebf51643115e099aff13c8a4640fa980d693eaa69312d5fa368130b17137` |

Aggregate comment as committed:

```
# aggregate rows=3 serialized_bytes=251 sha256=12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c
```

| Item | Value |
| --- | --- |
| Rows | `3` |
| Serialized bytes | `251` |
| Aggregate SHA-256 | `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` |

The aggregate recomputed from the artifact bytes equals the aggregate recorded by the
build run. No mismatch occurred at any stage; nothing was waived.

## 5. Evidence index pointers

| Pointer | What it establishes |
| --- | --- |
| `docs/evidence/releases/A/manifest.txt` | The binding of the three file names to their byte counts, LF counts, SHA-256 values and the aggregate. |
| `docs/evidence/releases/A/site/app.js` | Retained bytes, verified against the manifest. |
| `docs/evidence/releases/A/site/index.html` | Retained bytes, verified against the manifest. |
| `docs/evidence/releases/A/site/styles.css` | Retained bytes, verified against the manifest. |
| `https://github.com/ModernNomad-98/aegis-consumer-proof/actions/runs/40794805183` | The build run that produced the artifact; mode=build, no deploy step exists in that job. |
| `https://api.github.com/repos/ModernNomad-98/aegis-consumer-proof/actions/artifacts/12863007897` | Provider-side artifact metadata: id, size, digest, `expires_at` 2027-01-27. |
| `docs/evidence/index.md` | Index entry carrying this record's SHA-256. |
| `.github/workflows/pages.yml` | The committed deploy gate whose content gates are replayed at deploy time. |

## 6. Known UNRUN

These were deliberately not executed. They are not "passed"; they are unexecuted.

- **The deploy job has never run.** `mode=deploy` has not been dispatched for release A.
- **`actions/upload-pages-artifact` in deploy mode has never run.** No artifact was
  produced from the retained path.
- **`actions/deploy-pages` has never run.** No Pages deployment was created or requested.
- **The `github-pages` environment has never been entered** for this repository, so any
  environment protection or required-reviewer behaviour is unexercised.
- **Live serving is unverified.** `https://modernnomad-98.github.io/aegis-consumer-proof/`
  returns HTTP 404, as expected for a repository with no Pages build and no deployment.
- **Post-deploy RV-3 checks are unrun**: URL returns 200, served bytes match the retained
  manifest, and a browser pass over the published page.

The `github-pages` environment currently has one protection rule, a branch policy for
`main`, and **no required reviewers**. The R-A gate is therefore procedural: what stops
an unauthorized deploy is the owner's explicit answer, not environment protection.

Provider state observed while writing this record: deployments **0**, Pages builds **0**,
site URL **404**.

## 7. Rollback source

Nothing is deployed, so there is no live state to roll back today.

The bytes that would be published are reproducible from two independent sources: the
build artifact `12863007897` (retained until 2027-01-27) and the committed `site/` at
candidate commit `8c5eaf0f4b852cc7456d0a69b4cf08fd241126f3`. Either can regenerate
`manifest.txt` exactly. This is a source for re-deploying the *same* release A bytes; it
is not an earlier release to fall back to.

Release A is the repository's **first publication**. There is no earlier bundle or
earlier live state to restore:

- **A failed deploy does not unpublish.** If `deploy-pages` does not succeed, the URL
  keeps its prior state (404 today); GitHub Pages continues to serve the last successful
  deployment.
- **Reverting the bundle commit is not a rollback.** Reverting
  `5fcea3c2bda66ed9beedec82d09a7f953e6a69cc` removes `docs/evidence/releases/A/` at the
  new head, so the committed gate fails closed (`missing retained directory`) instead of
  publishing older content.
- **Only unpublishing returns the URL to 404.** Once a deployment succeeds, removing it
  from live serving requires unpublishing or disabling Pages, a Pages settings change.
  It is excluded from R-A and needs its own owner authorization.

Approving R-A is therefore **not reversible by R-A**. It authorizes the first
publication and the live state that follows; undoing that live state needs a separate
owner decision outside this request.

## 8. Authority

**Deployment requires the owner's R-A answer. No answer means no deployment.**

This record is evidence of content-gate readiness only. It authorizes nothing. The
deploy dispatch is a manual, owner-authorized action; the fail-closed default is that
the workflow remains un-dispatched and the site remains unpublished. Committing this
record is content only and publishes nothing.
