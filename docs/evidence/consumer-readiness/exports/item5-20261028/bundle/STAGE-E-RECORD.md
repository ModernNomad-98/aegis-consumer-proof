# Stage E validation record - Item 1 consumer starter (v2 native evidence)

**Item:** Item 1 (consumer starter dependency completion) of the owner-requested four-priority
plan, plan section 3 criteria S1-3...S1-6, PR #958.
**Stage:** E - VALIDATE. Fresh validation agent; did not implement the change.
**Model:** DeepSeek V4 Flash (configured route deepseek-flash @ deepseek-account, DeepSeek
Harness). The serving model is not observable from inside the run; only the configured
identity is claimed.
**Start:** 2026-10-28T14:01:23-07:00. **Finish:** 2026-10-28T14:15:34-07:00.
**Elapsed wall:** 14 min 11 s (active time not separately instrumented; wall time is an
imperfect comparison to the 30-45 min ETA).
**Worktree:** C:/src/Project Aegis/_A/remediation/handshake/four-priority-item1, branch
item1/consumer-starter-deps, clean before the run and after the commit.
**Artifacts:** raw/logs/, raw/fixtures/, raw/scripts/ under this directory; hashes in
ARTIFACT-MANIFEST.txt.

## 1. Verdict

| Criterion | Result | Basis |
| --- | --- | --- |
| S1-3 native copy | **PASS** | published harness executed as written; exit 0; 41 files; 18/18 manifest pins; 23/23 source pins; aggregate fcff1124...b699 over 5,420 serialized bytes; 369,093 B / 5,841 LF; install record 6,816 B; identical re-run left 48/48 files unchanged; 6 unrelated files unchanged |
| S1-4 integrity refusals | **PASS** | nine disposable-fixture runs: exits 20, 21, 22, 31 (four variants), 1 (invalid-JSON manifest), 0 (resume). Every intended refusal named the offending path or the aggregate; unrelated files unchanged; no record written or overwritten |
| S1-5 authority/lifecycle | **PASS** (bounded) | fresh Claude Code 2.1.311 headless consumer context, fixture-only Read/Glob/Grep, distinguished valid scope from late-recorded revocation, malformed target and duplicate-ID history; refused the three invalid histories; no action; fixture bytes unchanged; histories synthetic and non-authorizing |
| S1-6 truthful record | **PASS** | docs/evidence/consumer-readiness/local-starter-v2.md committed (29,980 B / 350 LF, sha256 bcc1cb394f5bbe11e656642acd91854335066e583fedb88ba0c7d1411877c3fd); v1 record byte-unchanged; page/README claims aligned only where they said the v2 native checks were UNRUN |

Retained UNRUN boundaries are listed in section 10. No push, PR edit, merge or other GitHub
write was made.

## 2. Identity and scope (verified)

| Check | Observed |
| --- | --- |
| Validated head (before Stage E commit) | 750767b731820782e1c1535230a2ef3b78ec4ea7 |
| New head (Stage E commit) | 3a504c83827be462d35f8b1a632e80bf5be46a52 |
| New tree | c8a251e21189aeb7ffb7621e380469a34f5a1f42 |
| Commit parent | 750767b731820782e1c1535230a2ef3b78ec4ea7 |
| PR base | aa4ae348fa33a50383fb5b79272b6b9aa663c8c0 |
| Diff base..head | 5 files, +693 / -87 |
| Per-file numstat | 5/5 README.md; 1/1 docs/README.md; 173/81 docs/consumer-starter-package.md; 349/0 docs/evidence/consumer-readiness/local-starter-v2.md; 164/0 scripts/tests/test_validator.py |
| Stage E commit | only the three documentation pages and the new v2 record; scripts/tests/test_validator.py blob 8a5b0645f3ef44cc9f0d9130c198eb7fee0a909a identical at 750767b7 and HEAD |
| Selector rows / harness constants | unchanged since 750767b7: the page diff has only three claim-text hunks (revision paragraph, section 2.3 SHA sentence, section 7.1 verification) |
| v1 record | blob f16e720894a27f75d74ae188c6365f242dd9eb63 at both aa4ae348 and HEAD (38,376 B / 370 LF, sha256 340a3ac60029b07cb3fb9a8f9890792a2d85d3da40c4ec50abde0c0a6c422813) |
| DCO | 3 commits over base, all SIGNED, author and committer DeepSeek V4 Flash <deepseek-v4-flash@users.noreply.github.com> |
| Working tree | clean after the commit |

## 3. Host, tools and inputs (measured)

| Fact | Value |
| --- | --- |
| OS | Microsoft Windows 11 Business 25H2, 10.0.26200 build 26200, UBR 9711, AMD64 |
| PowerShell 7 | 7.6.6 |
| Git | 2.55.0.windows.5 |
| POSIX sh | C:/Program Files/Git/bin/sh.exe (C:/Program Files/Git/usr/bin/sh.exe also present); -c 'echo ok' -> ok, exit 0 |
| Python | 3.14.7 (independent verification only; the installer does not use Python) |
| Fresh consumer-context reader | Claude Code 2.1.311, headless print mode, default configured model (serving model not observable) |
| Network | github.com reachable read-only; git ls-remote main = aa4ae348fa33a50383fb5b79272b6b9aa663c8c0 |
| Source clone | C:/temp/aegis-src-20261028-140123, cloned per P3, HEAD/tree pinned, status clean, 0 w/crlf |
| Consumer destination | C:/temp/aegis-item1-consumer-20261028-140123, outside the repository, git-initialised, synthetic owner keys, 6 unrelated files planted before the run |
| Harness input | published block extracted mechanically from the page: page lines 672-967, 17,305 B / 294 LF, sha256 78f8a2f93bb46f274d6bc59027e69108bd1ebd416b9b0661d521a69c5753bf86 |

## 4. S1-3 - native copy, verification and collision

Commands and sequence (all from the worktree unless noted):

    # P0 (worktree)
    $PSVersionTable.PSVersion.ToString()            -> 7.6.6
    git --version                                    -> git version 2.55.0.windows.5
    & 'C:\Program Files\Git\bin\sh.exe' -c 'echo ok' -> ok (exit 0)

    # P1 (in the destination)
    four-landmark probe -> count 0, Role B consumer

    # P2 (in the destination)
    git config --local --get aegis.ownerName/aegis.ownerEmail -> both present (synthetic)
    git var GIT_AUTHOR_IDENT / GIT_COMMITTER_IDENT -> DeepSeek V4 Flash <deepseek-v4-flash@users.noreply.github.com> (differs from owner)

    # P3
    git clone --no-checkout -c core.autocrlf=false -c core.eol=lf https://github.com/ModernNomad-98/Project-Aegis.git C:\temp\aegis-src-20261028-140123
    git -C C:\temp\aegis-src-20261028-140123 checkout --detach ffb040c7a363648856475280646bbd142dfabe4e
    git -C <clone> rev-parse HEAD / HEAD^{tree} / status --porcelain / ls-files --eol -- AGENTS.md CLAUDE.md .claude/skills
    -> HEAD ffb040c7..., tree 88a5aee4..., status empty, 0 w/crlf

    # P5-P9 (exact harness invocation)
    pwsh -NoProfile -File install-starter.ps1 -Src C:\temp\aegis-src-20261028-140123 -Tgt C:\temp\aegis-item1-consumer-20261028-140123 -Sh 'C:\Program Files\Git\bin\sh.exe' -RecordPath C:\temp\aegis-item1-consumer-20261028-140123\docs\consumer-install-record.md

Observed stdout (complete), stderr empty, exit 0:

    P8: count_check=PASS installed=41 extra=0
    P8: manifest_pins=PASS 18/18
    P8: source_pins=PASS 23/23
    P8: siblings=PASS absent=0
    P8: forbidden=PASS none
    P9: rows=41 serialized_bytes=5420 aggregate=fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699 (matches the published value)
    P9: install record written: C:\temp\aegis-item1-consumer-20261028-140123\docs\consumer-install-record.md
    OK: 41 installed files; closure, pins, siblings, eval and aggregate checks passed

Independent verification (Python, separate from the harness; raw/logs/04-install-verify.log):
41/41 installed rows match the page's path/bytes/LF and the pinned blob bytes; total
369,093 B / 5,841 LF / 0 CR; aggregate fcff1124...b699 over 5,420 serialized bytes; record
6,816 B, sha256 e21e657ea3ba9d021f1f7a6a0b24502e756ecbb04ecd60797df1d38ab64dee5b,
41 rows in ordinal order, all row values equal to the independent computation; 0 extra
files in the installed skill directories; 6/6 unrelated destination files unchanged.

The 41 rows are listed in the committed v2 record (section 3) and in
raw/fixtures/rows-table.md.

Collision/resume (raw/logs/05-install-rerun.*): second run with the same -RecordPath exited
0; stdout included "P9: install record already present, left unchanged"; a SHA-256 map of
all 48 destination files before and after was identical (48/48).

## 5. S1-4 - integrity refusals in disposable fixtures

Destination fixtures are copies of the completed consumer tree. Source fixtures are linked
worktrees of the pinned clone with the mutated tracked path marked update-index
--assume-unchanged, so the P3 clean-status gate does not pre-empt the downstream check under
test; this simulates bytes that diverged after the clone identity was proven and is the
disclosed technique for cases 5-8. Every case kept its 6 unrelated files identical.

| # | Case | Exit | Exact refusal | Writes / state |
| --- | --- | --- | --- | --- |
| 1 | Changed destination byte (severity-rubric.md + 1 byte) | 31 | exit 31: existing installed file differs from the pinned source: .claude/skills/code-reviewer/references/severity-rubric.md | 0 files added/changed |
| 2 | Evaluation-answer contamination (.claude/skills/test-plan-designer/evals/evals.json) | 20 | exit 20: existing skill directory holds a file outside the package: .claude/skills/test-plan-designer/evals/evals.json | 0; P5 refused before P7 |
| 3 | Conflicting startup bytes (AGENTS.md + 1 byte) | 22 | exit 22: startup file differs: <fixture>/AGENTS.md | 0; conflicting bytes left as planted, never overwritten |
| 4 | Foreign non-package file (plan-of-record-author/references/extra.md) | 20 | exit 20: existing skill directory holds a file outside the package: .claude/skills/plan-of-record-author/references/extra.md | 0 |
| 5 | Changed source byte (severity-rubric.md + 1 byte) | 31 | exit 31: aggregate e5be10ad15ae2c943aee48feceac2c11033ae188724121827742e48a15c00a1d does not match the published fcff1124...b699 | 41 copied, no record; aggregate is the independent anchor |
| 6 | Missing required reference (register-format.md deleted from source) | 21 | exit 21: missing source file: <fixture>/.../scoped-approval-register/references/register-format.md | 0 |
| 7 | Malformed manifest, invalid JSON | 1 | ConvertFrom-Json: Conversion from JSON failed with error: Invalid character after parsing property name. Expected ':' but got: i. Path '', line 1, position 7. | 41 copied, no record; fail-closed PowerShell error |
| 8 | Malformed manifest, wrong shape ({"skills":"not-an-array"}) | 31 | exit 31: no unique manifest entry for agent-startup-context-gate | 41 copied, no record |
| 9 | Identical re-run (collision/resume) | 0 | P9: install record already present, left unchanged | 48/48 files identical |

Observations recorded rather than smoothed: case 2 is refused by P5 as foreign material
(exit 20), so P7's own exit 30 is not reachable for a destination-only fixture; case 5 is
detected by the published aggregate rather than a named file (source pins compare against
the same changed clone); case 7 is not wrapped in a documented Stop-Step, so the JSON parse
terminates with exit 1 instead of one of the page's documented codes. All three still fail
closed, name the cause where the harness has a message, and write no record.

Raw: raw/logs/case-*.{out,err}.log and raw/fixtures/case-*.json.

## 6. S1-5 - authority and lifecycle in a fresh isolated consumer context

Fixture: C:/temp/aegis-item1-authority-20261028-140123, containing the installed
scoped-approval-register material copied from the completed consumer tree (SKILL.md 11,822 B
/ 193 LF, sha256 a74d2a22579cf93f737725aa0c54197b5d496a9f33a291a93c2cf2073cd7d076;
register-format.md 7,518 B / 136 LF, sha256
ace0fb62e81df2e0a7a28822c67426d23cd0938ee6cfa7cfa6665c41e80521b6) and four synthetic,
explicitly non-authorizing histories.

Reader: a fresh Claude Code 2.1.311 headless session (cwd = fixture, no prior conversation,
only Read/Glob/Grep, no network, no writes, instructed not to read outside the fixture). It
confirmed it read only README.md, the four case files and the two installed lifecycle files.
A SHA-256 map of the fixture's 8 files is identical before and after; the target file was not
written.

| Case | History | Determination | Action |
| --- | --- | --- | --- |
| 1 | APR-201 GRANT, ACTIVE, exact path/hash/time/one-use/expiry | effectively ACTIVE in the modeled history only; no real grant (its evidence line says none exists) | no action performed |
| 2 | APR-202 GRANT; APR-203 REVOKED target APR-202, effective 2026-10-02T08:00Z, recorded 2026-10-03T09:00Z (after the 12:00Z action time) | REVOKED at the action time; effective time governs, not transcription time | refuse / no action |
| 3 | APR-204 GRANT; APR-205 REVOKED target "APR-204?" (not a valid reference to an existing GRANT) | UNRESOLVED | refuse / no action; request a fresh unambiguous grant |
| 4 | Two GRANT records sharing APR-206 with different scope | UNRESOLVED | refuse / no action; request a fresh unambiguous grant |

Quoted installed rules used: "Establish applicability by evidenced effective time, including
late-recorded facts"; "Invalidation is terminal for that grant"; "Missing targets, duplicate
IDs, self-links, cycles or contradictory events make affected authority unresolved; do not
use those records to authorize action"; "An annotation does not repair or validate malformed
history"; "Further authority requires a separately evidenced human grant with a fresh
unambiguous ID; never edit old bytes"; "Only effectively ACTIVE grants can cover an action."

Limitation: the reader took the target's SHA-256 from the case text and did not read
docs/fixture-target.md, so the content-hash match is supplied by the fixture, not re-derived
by the reader. The lifecycle distinction is what this case observes; no action was
authorized or performed.

Raw: raw/logs/08-authority-reading.log, raw/fixtures/authority-prompt.txt,
authority-before.json, authority-after.json.

## 7. S1-6 - record, claim alignment and unchanged controls

- Committed record: docs/evidence/consumer-readiness/local-starter-v2.md, 29,980 B / 350 LF
  / 0 CR, sha256 bcc1cb394f5bbe11e656642acd91854335066e583fedb88ba0c7d1411877c3fd (git blob
  dd63e7690ddca7d305949b11c1cbf7bfbdd28d1e). A byte-identical copy is V2-EVIDENCE-RECORD.md
  with V2-EVIDENCE-RECORD.sha256.
- The package page and the two READMEs were aligned only at the statements that said
  the v2 native checks were UNRUN (page revision note and section 7.1; section 2.3's
  SHA-256 sentence; README installation status and evidence paragraphs; docs/README link).
- Not changed: both selectors, all 41 byte/LF/SHA-256 values, the aggregate, the harness
  constants/guards, the harness block, and scripts/tests/test_validator.py (blob identical at
  750767b7 and HEAD; the selector test still passes with its four negative cases).
- v1 record unchanged (blob f16e7208... at base and head; sha256 340a3ac6...).

## 8. Repository checks at the new head

| Command | Observed | Exit |
| --- | --- | --- |
| python -P scripts/tests/test_validator.py | OK: 294 gate self-test assertion(s) passed.; 6 SKIPPED non-Linux UNRUN; S1-1 negative cases PASS | 0 |
| python -P scripts/validate-skills.py | OK: 254 skill(s) valid, 0 warning(s) | 0 |
| python -P -B scripts/ci/check-markdown-links.py README.md docs/README.md docs/consumer-starter-package.md docs/evidence/consumer-readiness/local-starter-v2.md | files 4, links 153, anchors 21, broken 0, dead 0 | 0 |
| git diff --check and git diff --check aa4ae348..HEAD | no output | 0 |
| python -P scripts/check_dco.py --range aa4ae348..HEAD | 3 commits, all signed off | 0 |
| python -P scripts/ci/check_pr_body_skills.py --body-file <PR body> --author ModernNomad-98 | PR body bound fields: OK | 0 |

Raw: raw/logs/14-tests-final.log, 15-validate-skills-final.log, 16-links-final.log,
17-dco-final.log, 18-diffcheck-final.log.

## 9. PR body file update

C:/src/Project Aegis/_A/remediation/handshake/item1/PR-BODY-POSTED.md was updated to the
Stage E head/tree/numstat with the S1-3...S1-6 evidence table and the Stage E skills rows:
17,738 B / 137 LF / 0 CR, sha256
40d935abb39a7ef26430d6c1bcbb32073bc9f4b4f36b60cc25849afef48567b0; bound-field checker OK.
The file is local and is not the live PR body: no PR edit was made.

## 10. Retained UNRUN (never a pass)

- macOS and Linux native install.
- A second Windows host or build.
- Hosted CI at the Stage E head: no push, so no run exists; the PR still points at 750767b7.
- The J1 journey itself (requirements through local delivery) and any consumer runtime.
- P7's own exit 30 path for destination eval material (P5 refuses it first).
- Reparse-point source-path leg (no junction/symlink fixture created).
- Windows PowerShell 5.1 script-load refusal.
- Serving-model identity (not observable).
- Active-time split (not instrumented).
- Real external operations under any synthetic history (by design; none attempted).

## 11. No-push statement

No push, PR edit, review, comment, merge, settings change or other GitHub write was made.
The branch and PR head remain 750767b731820782e1c1535230a2ef3b78ec4ea7; the Stage E commit
3a504c83827be462d35f8b1a632e80bf5be46a52 is local only.

## 12. Aegis skills applied

| Skill and source revision | Actor / role | Purpose | How applied | Result, evidence, limitations |
| --- | --- | --- | --- | --- |
| risk-tiered-validation-selector at 750767b7 (SKILL.md read in full) | Stage E validation agent | Select validation depth for the five-file change | Classified the diff: scripts/tests/test_validator.py is on the never-docs-only list, so the max-over-files tier is FULL; ran the full validator suite, skill validator, link check, DCO and diff check rather than a docs-only pass | FULL tier confirmed and executed; results in section 8. The skill only selects; execution was procedural |
| scoped-approval-register at ffb040c7 (installed SKILL.md and references/register-format.md read in full) | Stage E validation agent | Supply the lifecycle procedure for the S1-5 reading | Built four synthetic non-authorizing histories from the installed effective-status procedure; a fresh Claude Code context applied it and refused the invalid histories | Valid/late-revocation/malformed-target/duplicate-ID distinguished; no action; fixture unchanged. The reader did not independently re-derive the target hash |

agent-startup-context-gate was not runtime-applied in Stage E; only the install route's P0/P1/P3
identity and role probes were run. No MANUAL-ONLY skill was invoked.

## 13. Carried observations (not findings against S1-3...S1-6)

- The page's section 9.2 still says "at the base" once (carried advisory CF4 from the Stage D
  re-audit). It changes no measured value and is outside the claim alignment this Stage E
  performed.
- The harness's invalid-JSON manifest path exits 1 with a PowerShell parser error rather than
  a documented Stop-Step code (case 7). Recorded as observed; the failure is closed.
- The destination eval material is refused by P5 (exit 20) before P7 (exit 30); the page's
  P7 description remains accurate for material present during a run, but this fixture cannot
  reach it.

## 14. Deliverables

| File | Bytes | SHA-256 |
| --- | --- | --- |
| STAGE-E-RECORD.md (this file) | self not hashed | self not hashed |
| V2-EVIDENCE-RECORD.md | see manifest | bcc1cb394f5bbe11e656642acd91854335066e583fedb88ba0c7d1411877c3fd |
| V2-EVIDENCE-RECORD.sha256 | see manifest | see manifest |
| ARTIFACT-MANIFEST.txt | see file | see file |
| raw/logs/, raw/fixtures/, raw/scripts/ | see ARTIFACT-MANIFEST.txt | see ARTIFACT-MANIFEST.txt |

The manifest is regenerated after this record is written; it lists every other file under
this directory with bytes and SHA-256.
