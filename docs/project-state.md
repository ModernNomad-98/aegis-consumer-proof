# Project state — checklist consumer repository

**Record type:** durable state and next-action record for
`ModernNomad-98/aegis-consumer-proof`. It is a projection of committed evidence. It grants
no authority, changes no setting, publishes nothing, and is not a CP verdict.

| field | value |
| --- | --- |
| Repository | `ModernNomad-98/aegis-consumer-proof` (public) |
| Record branch | `aep3-i2/next-action-record` (new, non-main; based on `aep3-i2/startup-readback`) |
| Base commit (parent of the commit that adds this file) | `338ba8240e74aa6b70083121ff4f495804ea63e7` |
| `main` at the provider when this record was written | `390363f66c72f81834b9d910b6859ff82ea45bda` |
| Commit that adds this file | read `git log -1 --format=%H -- docs/project-state.md` — a file cannot contain its own commit id |
| Binding owner policy | SDP-1, `docs/evidence/owner-decisions/SDP-1.md`, in force from 2026-10-28 |
| Status | current; change it by appending a new `PS-` row, never by editing a past row |

The branch name is a label, not a decision. Derive the next action from this file and the
committed evidence it cites — not from a branch name, a chat message, or an inference.

## 1. State snapshots (append-only — the latest row is the current state)

| ID | Date | Current state | Next recommended action |
| --- | --- | --- | --- |
| PS-001 | 2026-10-29 | Release A is live. Release B is built and retained, not published. SDP-1 is in force. The installed starter and this record are on non-main branches; `main` is unchanged. | Verify the SDP-1 item 4 conditions for R-B (section 3). Stop if any is unmet. Do not dispatch from a read-only continuation. |

## 2. What the committed records establish

| Fact | State | Evidence (path, section, SHA-256) |
| --- | --- | --- |
| Release A | **Live.** Deployment `7401326753` (`github-pages`, `main`, sha `7591c657010685fa5fe158fb73828f73a26bbb98`) has status `success`; the URL returned HTTP 200 and the served bytes reproduce aggregate `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c`. The retained manifest binds the three A files. | `docs/evidence/deployments/A.md` §5–§13 — 13,470 B, 263 LF, `6877c4a4c084bae83044fadbb31b4c80702e065de8c19e1dc631472bc9624f3e` |
| Release B | **Built and retained, not published.** Build run `40801962008` (attempt 1) succeeded; artifact `12865394868`; aggregate `36bc4407514265db0bd0fcaa9dde87ad2db18373ed5646fd178ec97af5a9ba4a`; the deploy job was skipped; there is no B deployment id or status. The retained manifest binds the three B files. | `docs/evidence/release-readiness/B.md` §3–§4, §6 — 12,184 B, 202 LF, `5cf82dfcbfa6a9f81ce138bcbfd9dc89b6810151489ae30de5d2067d23e36b9e` |
| Owner policy | **SDP-1 in force** from 2026-10-28. Item 4 conditionally pre-grants the release steps R-B, R-RB1 and R-RB2. Item 6 keeps settings changes, unpublish, the U6 publication grant, merges outside a grant, and spend with the owner. | `docs/evidence/owner-decisions/SDP-1.md` lines 14–15, 45–51, 57–63 — 9,321 B, 146 LF, `5a84295101890bfee134e094b76d0e584435944f8c7b633a8ae8aa1446708894` |
| Installed starter | **41 files at the repository root**, pin `ffb040c7a363648856475280646bbd142dfabe4e`, aggregate `fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699`; the vendor copy stays alongside. It is not on `main`. | `docs/consumer-install-record.md` §3, §7, §9 — 15,560 B, 194 LF, `e5ecd63e2c793f457a29731a76416deb411ae95e35124f8f74e02f43c2dda25c`; `HASH-MANIFEST.tsv` — 5,420 B, 41 LF, `fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699` |
| Deploy workflow | **One manual two-mode workflow.** Deploy mode reads the committed retained bytes and `manifest.txt` from the same commit and fails closed on a missing or mismatched bundle. It has no push trigger. | `.github/workflows/pages.yml` — 13,041 B, 276 LF, `8c4754753137a89484cf5f4c1592f0243263a3bc2d97f85ebb907132b080b381`; `docs/evidence/release-readiness/B.md` §4 |
| Evidence register | The index binds the records above. It deliberately carries no hash entry for this mutable record; the record carries the hashes instead. | `docs/evidence/index.md` — 5,087 B, 61 LF, `5bf536742c78fd109df28fa0d22206a2a9702270535c68f2a316b57edabfab29` |

**Readiness A is a pre-deployment snapshot.** Its status line says "deployment NOT
dispatched; nothing is live" because it was written before the R-A dispatch. It is not
edited after the fact. The later record, `docs/evidence/deployments/A.md`, is the one that
establishes A live.

## 3. Next action

**Next action (do this first): re-verify the SDP-1 item 4 conditions for R-B, starting with
the live state and the unposted evidence report. Stop if any condition is unmet. Do not
deploy, merge, publish U6 material, or change settings from this record.**

A read-only continuation stops after reporting the verification. It does not dispatch.

### Step 1 — verify the live state first (read-only)

Re-observe the provider state and confirm the committed picture: release A is still the
served release — deployment `7401326753` is the latest deployment and has status `success`;
there is no release B deployment; the URL serves A's aggregate
`12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c`. This observation is
also condition (d) and must be made **inside the 5-minute window** before any dispatch.

### Step 2 — check the four conditions

| # | SDP-1 item 4 condition | State in the committed record | What to do |
| --- | --- | --- | --- |
| (a) | The previous step's evidence report is posted with observed values. | **NOT MET** — readiness B §8 records the release B build evidence report as prepared and not posted. | Do not treat R-B as exercisable. Record the exact gap and ask the owner only for this condition. |
| (b) | The committed deploy gate replays PASS at the dispatch commit and FAILS CLOSED at the pre-bundle commit. | **MET only as a local replay** — PASS at `745f064f8767474e6cef22ccd5309edcb8f6ebdc`, FAIL-CLOSED at `d248d7cc666e68dc689e51f34b1a152c367d1af5`; readiness B §8 says it must be replayed at the actual dispatch commit. | Replay it at the exact dispatch commit. |
| (c) | The step is inside the frozen case set. | **MET** — CP-16 is one of the 22 frozen cases (readiness B §8). | Do not re-ask this. |
| (d) | Prior state is re-observed within 5 minutes of dispatch. | **NOT MET** until step 1 is done inside the window. | Re-observe immediately before any dispatch. |

### Step 3 — stop rule

If any of (a)–(d) is not met, or the owner record required by readiness B §8 is absent,
**STOP**. R-B reverts to a per-ask decision. Record the exact unmet condition as UNRUN and
ask the owner only for that condition. Do not dispatch, do not retry, and do not substitute
R-RB1 or R-RB2.

### Step 4 — only if every condition holds

If (a)–(d) all hold and the owner record exists, the next action is **one** manual
deploy-mode dispatch of the committed `pages` workflow with `release=B`, with **no retry**,
followed by the observed deployment record. The authority is SDP-1 item 4 plus the owner
record; this file grants nothing.

### Step 5 — owner-only boundaries

U6 publication is **owner-only** under SDP-1 item 6 and no grant is recorded in this
repository: **HOLD**. The R-B pre-grant is not authority for U6, a settings change,
unpublish, spend, a merge outside a grant, or anything outside the frozen case set.

## 4. Settled — do not re-ask

- Release A has an owner answer of **YES** for one dispatch; deployment `7401326753` is
  recorded as `success`. Do not re-ask whether A may be published.
- Release B is built, reviewed and retained; the build run and artifact are recorded. Do
  not re-ask whether B should be built.
- SDP-1 is in force from 2026-10-28. Do not re-ask whether the policy applies.
- CP-16 is in the frozen case set. Condition (c) is met.
- The 41-file install is committed on non-main branches. No merge to `main` was granted.
- The branch name is not evidence. The next action is the one in section 3.

## 5. Genuinely open — the only questions for the owner

- Whether condition (a) has been satisfied by an evidence report posted outside this
  repository. Readiness B §8 records it as not posted.
- Whether the owner record required by readiness B §8 exists.
- If any condition fails: whether to authorize R-B as a per-ask decision.
- U6 publication is not an ask this record can make; it is owner-only and remains a HOLD.

## 6. Owner gates and authority

| Gate | Current status | Authority / pointer |
| --- | --- | --- |
| **R-B** | Conditional pre-grant; **not exercisable until (a)–(d) hold and the owner record exists**. A failed dispatch is never retried under the grant. | SDP-1 §1 item 4; readiness B §8 |
| **R-RB1** | Conditional pre-grant; **UNRUN**; release B is not live, and readiness B §7 records that there is nothing to roll back today, so it is not the next action. | SDP-1 §1 item 4; readiness B §7; `docs/evidence/deployments/A.md` §12 |
| **R-RB2** | Conditional pre-grant; **UNRUN**; same reason. | SDP-1 §1 item 4; readiness B §7; `docs/evidence/deployments/A.md` §12 |
| **U6 publication** | **HOLD** — owner-only; no grant recorded in this repository. | SDP-1 §1 item 6 |
| Settings change, Pages disable/unpublish, spend | Owner-only, no exceptions. | SDP-1 §1 item 6 |
| Merge to `main` | Not authorized by this record. This repository has no approval-register grant and no merge-by-agent path. | SDP-1a, "Effect on this repository"; SDP-1 §1 item 6 |
| Anything outside the frozen case set | Owner-only. | SDP-1 §1 items 5–6 |

## 7. UNRUN — not claimed by this record

- **Release B publication** — no B deployment id, no B deployment status, no Pages build
  for B (readiness B §6).
- **R-RB1 and R-RB2** — unexercised in this repository (deployments A §12).
- **Rendered browser behaviour** of A and B — CP-11 and the browser-dependent cases remain
  UNRUN.
- **The consumer acceptance set** — CP-01 through CP-22 remain UNRUN in this repository
  (deployments A §12). This record is not a CP verdict.
- **U6 publication** — not granted; HOLD.
- **Merge, pull request, workflow dispatch, deploy and settings change** — none was made
  from this record.
- **Conditions (a) and (d)** — not met as of this record; they are the first things to
  verify.
- **The install's negative probes** — recorded outside this repository (install record §9).

## 8. Evidence register (recomputed from the committed bytes)

| Path | Bytes | LF | SHA-256 |
| --- | ---: | ---: | --- |
| `docs/evidence/deployments/A.md` | 13,470 | 263 | `6877c4a4c084bae83044fadbb31b4c80702e065de8c19e1dc631472bc9624f3e` |
| `docs/evidence/release-readiness/A.md` | 7,613 | 149 | `b1dea6310314c439b39b0f9665a087e3c4a540a0a77c440ec9621ae0ca3cd9c5` |
| `docs/evidence/release-readiness/B.md` | 12,184 | 202 | `5cf82dfcbfa6a9f81ce138bcbfd9dc89b6810151489ae30de5d2067d23e36b9e` |
| `docs/evidence/owner-decisions/SDP-1.md` | 9,321 | 146 | `5a84295101890bfee134e094b76d0e584435944f8c7b633a8ae8aa1446708894` |
| `docs/evidence/releases/A/manifest.txt` | 363 | 4 | `897e222abcfc7a0fdbd5bc4c6df1933ff3e86364ba513810f4d5eb071ebe4479` |
| `docs/evidence/releases/B/manifest.txt` | 363 | 4 | `112edb0b3bfe469a5674aefbd3b74e8bc65baed02ef8aa07adea966aa62ca891` |
| `docs/evidence/index.md` | 5,087 | 61 | `5bf536742c78fd109df28fa0d22206a2a9702270535c68f2a316b57edabfab29` |
| `docs/consumer-install-record.md` | 15,560 | 194 | `e5ecd63e2c793f457a29731a76416deb411ae95e35124f8f74e02f43c2dda25c` |
| `docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7/HASH-MANIFEST.tsv` | 5,420 | 41 | `fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699` |
| `.github/workflows/pages.yml` | 13,041 | 276 | `8c4754753137a89484cf5f4c1592f0243263a3bc2d97f85ebb907132b080b381` |

## 9. How to refresh this record

Append a new `PS-` row; do not edit or reorder `PS-001`. Recompute every hash above from
the committed bytes. If a cited file no longer matches its hash, that is drift: report it,
do not silently update the row. Refresh by a content commit on a non-main branch; no merge
to `main` is granted by this record.
