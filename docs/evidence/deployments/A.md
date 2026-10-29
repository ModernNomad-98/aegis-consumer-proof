# Release A — deployment record

Repository: `ModernNomad-98/aegis-consumer-proof`. Release: A. Plan reference: RP-D-14.
Pre-deployment record for the same release: `docs/evidence/release-readiness/A.md`.

Status: **DEPLOYED — one dispatch, run `40798505740` success, deployment `7401326753`
`success`, site URL HTTP 200, and the served bytes reproduce the retained manifest
aggregate exactly. No Pages build record exists for this deploy (Pages `build_type: workflow`)
and none is invented. Nothing was retried, re-run or changed after the deploy.**

This record states what the deployment observed. It authorizes nothing further: every
release step after A stays where SDP-1 and the readiness record leave it.

## 1. Purpose (owner-visible)

Release A is live. One owner-authorized manual dispatch of the committed `pages` workflow in
deploy mode published the retained bytes at
https://modernnomad-98.github.io/aegis-consumer-proof/, moving the URL from 404 to 200.
This is the repository's first publication, so there is no earlier release to fall back to,
and unpublishing is an owner-only settings change (section 11).

`docs/evidence/release-readiness/A.md` stays the pre-deployment record. Its statement
"deployment NOT dispatched; nothing is live" was true of the commit it was written against
and is not edited here. This record describes current live state; it does not rewrite that
one.

## 2. Authorization

| Item | Value |
| --- | --- |
| Step | R-A, release A publication (not one of the steps item 4 of SDP-1 pre-grants) |
| Owner answer | **YES** — one dispatch, conditions (a)–(e) accepted |
| Source class | owner instruction, transcribed from the owner's session (chat); not a GitHub comment and not a provider record |
| Owner session | 2026-10-28 at about 18:05 PDT (2026-10-29T01:05Z) |
| Recorded in | the workspace owner decision record for R-A / A-13 / U8 dated 2026-10-28 (`_A/remediation/handshake/OWNER-DECISION-RA-A13-U8-2026-10-28.md`, 2,256 B, SHA-256 `1c47cf274ccde5cfd2c0650605b9eabb1c7b8ac1b70053c6955961a68499969d`). That record is workspace-local and **not committed to this repository**; the R-A answer and conditions (a)–(e) are recorded there, not in `item2-ra/R-A-REQUEST.md`, which is the workspace-only ask. |
| Dispatches made | **1** — no retry, no re-run, no second dispatch |

The owner also accepted that approving R-A is not reversible by R-A (section 11). The
`github-pages` environment has one protection rule (a branch policy for `main`) and **no
required reviewers**, so the R-A gate is procedural: what stops an unauthorized deploy is
the owner's explicit answer, not environment protection.

## 3. What was published

| Item | Value |
| --- | --- |
| Dispatch commit | `7591c657010685fa5fe158fb73828f73a26bbb98` |
| Dispatch commit tree | `af9d82f7fc3c32c71cebf588050fe0a9eebf1984` |
| Retained-bundle commit | `5fcea3c2bda66ed9beedec82d09a7f953e6a69cc` |
| Candidate commit (bytes originate here) | `8c5eaf0f4b852cc7456d0a69b4cf08fd241126f3` |
| Candidate tree | `0450a0f055d7b80448bca2824e3ad9273eab6002` |
| Workflow blob (`.github/workflows/pages.yml`) | `927bad72e9803a913dd71bb365311912449f1614` |
| Ref / environment | `main` / `github-pages` |

The gate reads the retained bytes from the dispatch commit. `docs/evidence/releases/A/` is
unchanged from `5fcea3c2`, and those bytes are byte-identical to `site/` at `8c5eaf0f`.

## 4. Prior state (immediately before the dispatch)

Observed 2026-10-29T01:07:39Z; URL HEAD at 01:07:44Z.

| Observation | Value |
| --- | --- |
| Deployments | **0** |
| Pages builds | **0** |
| Workflow runs | **1** — only `40794805183` (mode=`build`) |
| Pages config | `build_type: workflow`, `status: null`, `html_url` set |
| URL HEAD | **HTTP 404** |
| Head of `main` / tree | `7591c657010685fa5fe158fb73828f73a26bbb98` / `af9d82f7fc3c32c71cebf588050fe0a9eebf1984` |

## 5. The single dispatch

```text
gh workflow run pages.yml -R ModernNomad-98/aegis-consumer-proof --ref main -f mode=deploy -f release=A
```

| Field | Value |
| --- | --- |
| Start / end (UTC) | 2026-10-29T01:07:51.358Z / 2026-10-29T01:07:53.489Z |
| Exit code | **0** |
| Inputs | `mode=deploy`, `release=A` |
| Output | https://github.com/ModernNomad-98/aegis-consumer-proof/actions/runs/40798505740 |
| Second dispatch / retry | **NONE** |

## 6. Run and jobs

| Field | Value |
| --- | --- |
| Run id / attempt | **40798505740** / **1** |
| Workflow / event | `pages` / `workflow_dispatch` |
| Ref / head SHA | `main` / `7591c657010685fa5fe158fb73828f73a26bbb98` |
| Status / conclusion | `completed` / **`success`** |
| Created / updated | 2026-10-29T01:07:52Z / 2026-10-29T01:08:17Z |

| Job | Job id | Conclusion | Steps |
| --- | --- | --- | --- |
| `deploy (committed retained bytes only)` | **123200676832** | **`success`** | 9, all success |
| `build (assemble and retain; never deploy)` | **123200678387** | **`skipped`** | **0** |

Deploy-log values observed in the run:

```text
candidate_commit=7591c657010685fa5fe158fb73828f73a26bbb98
candidate_tree=af9d82f7fc3c32c71cebf588050fe0a9eebf1984
run_id=40798505740 run_attempt=1 release=A
manifest_verified release=A rows=3 serialized_bytes=251 aggregate=12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c
content_gates_replayed release=A files=3 cr_bytes=0 forbidden_material=0
deployment_url=https://modernnomad-98.github.io/aegis-consumer-proof/
deploy_artifact_id=12864139450
```

The build job produced no log lines: it was skipped with zero steps and published nothing.
The run wrote nothing back to the repository.

## 7. Deployment object

| Field | Value |
| --- | --- |
| Deployment id | **7401326753** |
| Task | `deploy` |
| Environment | `github-pages` |
| Ref / SHA | `main` / `7591c657010685fa5fe158fb73828f73a26bbb98` |
| Created / updated | 2026-10-29T01:07:53Z / 2026-10-29T01:08:17Z |
| Status id | **20870583721** |
| State | **`success`** |
| Status created | 2026-10-29T01:08:17Z |
| `environment_url` | https://modernnomad-98.github.io/aegis-consumer-proof/ — carried by the success status |

Status chain: `waiting` 01:07:54Z (20870565081), `queued` 01:07:55Z (20870565785),
`in_progress` 01:07:58Z (20870567875), `success` 01:08:17Z (20870583731). The deployment
object's own `environment_url` field is empty; the URL above is the value on the success
status. After the run there is **exactly one** deployment in the repository and in
`environment=github-pages`.

## 8. Pages build records — none exposed

| Observed (UTC) | Endpoint | Response |
| --- | --- | --- |
| after run completion | `GET /repos/…/pages/builds?per_page=100` | `[]` |
| 2026-10-29T01:09:54Z | `GET /repos/…/pages/builds?per_page=100` | `[]` |
| 2026-10-29T01:10:48Z | `GET /repos/…/pages/builds?per_page=100` | `[]` |
| 2026-10-29T01:10:48Z | `GET /repos/…/pages/builds/latest` | **HTTP 404** |

Pages config stayed `build_type: workflow` (unchanged). In that configuration publication
is performed by the workflow deployment through `actions/deploy-pages`, and the Pages builds
API exposed no record in any of the three reads or the latest-build probe. **No Pages build id
is fabricated**: the publication object for this deploy is deployment `7401326753`, not a
Pages build.

This is recorded as a **fail-fact** on the requested build-id evidence item. It is not a
deployment failure: the run succeeded, the deployment status is `success`, the URL serves
200, and the served bytes match the retained manifest.

## 9. HTTP 404 → 200

| Time (UTC) | Method | Status |
| --- | --- | --- |
| 2026-10-29T01:07:44Z (before) | HEAD | **404** |
| 2026-10-29T01:09:05Z | HEAD | **200** |
| 2026-10-29T01:09:05Z | GET | **200**, 1595 bytes |
| 2026-10-29T01:10:49Z | HEAD | **200** |
| 2026-10-29T01:21:45Z (after the commit that added this record) | GET | **200**, 1595 bytes |

Response headers at 01:09:05Z: `Content-Type: text/html; charset=utf-8`,
`Content-Length: 1595`, `Last-Modified: Thu, 29 Oct 2026 01:08:10 GMT`,
`ETag: "6ae29c7a-63b"`.

## 10. Served bytes against the retained bundle

Served files were fetched at 01:09:34Z and hashed from the **served** bytes, not from the
repository copy.

| Served file | Bytes | LF | SHA-256 |
| --- | --- | --- | --- |
| `app.js` | 11072 | 427 | `e4e970ff10ccd42d5c868193f59d3e7222d565ad1c96bff3e32843e410906281` |
| `index.html` | 1595 | 40 | `e2e1ceecb84981c248aadbcec1650b1f0e1a468ed308640cb03e64bc6bd5b8f8` |
| `styles.css` | 3860 | 247 | `1874ebf51643115e099aff13c8a4640fa980d693eaa69312d5fa368130b17137` |

| Check | Result |
| --- | --- |
| Serialized manifest (`name<TAB>bytes<TAB>LF<TAB>sha256<LF>`, byte-sorted) | **251 bytes** |
| Recomputed aggregate | `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` |
| Required aggregate | `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` |
| Aggregate match / rows match | **YES** / **YES** (rows = 3) |
| Served `index.html` vs retained `index.html` | both 1595 bytes, both `e2e1ceec…5b8f8`, **byte-identical** |
| Each served row vs the retained `manifest.txt` row | equal |

Re-checked while this record was written: the retained bytes in this repository still
recompute to `rows=3`, `serialized_bytes=251`, aggregate `12ad18e1…867c`; the URL returns
200 with 1595 bytes; and the served `index.html` SHA-256 equals the retained copy's.

## 11. Irreversibility

- **R-A is not reversible by R-A.** Release A is the first publication: no earlier bundle and
  no earlier live state exists, so there is nothing to redeploy as a rollback.
- **A failed deploy does not unpublish.** Pages keeps serving the last successful deployment,
  so a failed dispatch returns the URL to its prior state only while nothing has been
  published.
- **Reverting `5fcea3c2` is not a rollback.** It removes the retained directory, so the
  committed gate fails closed (`missing retained directory`) and publishes nothing. It does
  not remove deployment `7401326753`.
- **Only unpublishing or disabling Pages returns the URL to 404.** That is a Pages settings
  change: owner-only under SDP-1 item 6, not covered by R-A, and it needs its own owner
  authorization.

The bytes are reproducible from build artifact `12863007897` (retained until 2027-01-27) and
from `site/` at `8c5eaf0f`, but reproducibility of bytes is not rollback of live state.
Undoing the live state is an owner decision outside R-A.

## 12. Known UNRUN

These were not executed. They are not "passed"; they are unexecuted.

- **No browser pass over the published page**; accessibility, cross-browser and storage tests
  are unrun.
- **The consumer journey and cases A-01…A-13 / CP-01…CP-22 are UNRUN.** This deployment proves
  publication, not acceptance.
- **Release B, R-B, R-RB1, R-RB2 and R-EMPTY are UNRUN.** The R-A answer covers release A's
  publication only.
- **Rollback, redeploy and unpublish are UNRUN** — not authorized.
- **A Pages build record could not be produced** (section 8).
- **Account audit-log review is UNRUN** — the token cannot read it.

## 13. Provider state after the deployment

| Field | Before (01:07:39Z) | After |
| --- | --- | --- |
| Deployments | 0 | **1** — `7401326753`, `success` |
| Pages builds | 0 | **0** (section 8) |
| Workflow runs | 1 | **2** — `40794805183` (build), `40798505740` (deploy); both `workflow_dispatch`, attempt 1 |
| Pages `build_type` / `status` | `workflow` / `null` | unchanged |
| Pages `html_url` | set | unchanged |
| URL | 404 | **200** |
| Environment `github-pages` | 1 branch policy, 0 required reviewers | unchanged |
| Head of `main` | `7591c657…` | advanced after the dispatch by content-only commits |

`main` advanced after the dispatch — `7591c657…` → `1e754df7…` → `66c602bd…` → the commit
that added this record — by content-only evidence commits: SDP-1 registration, the SDP-1a
clarification and this record. None of
those commits created a deployment, a Pages build or a workflow run — the workflow has no
push trigger — and none changed the workflow, the retained bundle or `site/`. The deployment
stays bound to `7591c657…`: deployment `sha` = run head SHA = dispatch commit.

## 14. Evidence pointers

| Pointer | What it establishes |
| --- | --- |
| https://github.com/ModernNomad-98/aegis-consumer-proof/actions/runs/40798505740 | The single deploy-mode run: `workflow_dispatch`, `main`, head SHA `7591c65`, `completed/success`. |
| `GET /repos/…/actions/runs/40798505740/jobs` | Deploy job `123200676832` `success`; build job `123200678387` `skipped` with 0 steps. |
| `GET /repos/…/deployments/7401326753` | Deployment identity: `github-pages`, `main`, `7591c65`, created 01:07:53Z. |
| `GET /repos/…/deployments/7401326753/statuses` | The status chain ending in `success` (20870583731) at 01:08:17Z with the `environment_url`. |
| `GET /repos/…/pages/builds` | `[]` before and after: no build record exists under `build_type: workflow`. |
| `docs/evidence/releases/A/manifest.txt` | The binding of the three names to bytes, LF counts, SHA-256 values and the aggregate. |
| `docs/evidence/releases/A/site/*` | The retained bytes the gate read and that the served bytes were compared against. |
| `docs/evidence/release-readiness/A.md` | The pre-deployment record for this release. |
| `docs/evidence/index.md` | The entry carrying this record's SHA-256, byte count and LF count. |
| `.github/workflows/pages.yml` | The committed deploy gate whose content gates replayed inside the run. |

## 15. Authority

This record reports the observed result of one owner-authorized dispatch. It authorizes no
second dispatch, no retry, no redeploy, no unpublish and no settings change. Committing it is
content only: it publishes nothing and creates no provider object.
