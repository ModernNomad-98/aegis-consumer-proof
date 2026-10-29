# CP-21(B) owner-authorized settings change - `github-pages` deployment branch policy

**Register class.** SDP-1 section 1 item 6: any repository settings change still requires the
owner, no exceptions. This is that owner authorization, recorded as a dated settings change
with the revert evidence attached.

**Repository / environment.** `ModernNomad-98/aegis-consumer-proof` / `github-pages`

**Entry date.** 2026-10-29 (UTC) and 2026-10-29 (America/Los_Angeles, PDT, UTC-07:00). All
clock times below are UTC.

**Policy object under change.** deployment branch policy id `64714655`
(`node_id MDE2OkdhdGVCcmFuY2hQb2xpY3k2NDcxNDY1NQ==`), name `main`, type `branch`.

**Executed by.** the CP-21(B) execution agent.

**Recorded by.** the consumer register commit agent, 2026-10-29, from the retained execution
evidence; recording it changed no setting.

## 1. Owner authorization and its conditions

Owner decision **CP-21=B**, condition **(vi)**, given in the owner's direct session on
2026-10-29 and carried by the CP-21(B) execution brief. The same decision is called decision
(a) in the CP-21(B) execution record. Conditions (i)-(vi) bound the change and this entry:

| # | Condition | Disposition |
| --- | --- | --- |
| i | Dispatch the pass-after run from `main` first if it can be dispatched from main; only the fail-before run then needs the policy change. | Antecedent false: the selector's `refs/heads/main` fast path exits 0 before reading live state, so a main-ref pass-after dispatch would have deployed stale A instead of being refused. Both non-main dispatches therefore used the temporary policy. Determination: CP-21(B) execution record section 2.1. |
| ii | Add exactly the named ref(s) to the `github-pages` environment branch policy (id `64714655`); no wildcard, no all-branches entry, no other environment or setting. | Met: two exact branch names, one per branch; nothing else changed (section 2 and section 8). |
| iii | Record before/after readings around the change and prove the policy equals its before state after removal. | Met: four readings plus corroborating reads; A2 and B2 are byte-identical to B1 (section 3). |
| iv | Policy back to before within 60 minutes; on failure revert first; no retry. | Met: 2 min 6 s under change against a 60-minute limit; no failure occurred, the revert ran before the restore dispatch, and every run has `run_attempt = 1` (section 4). |
| v | One dispatch per run; served aggregate unchanged after both runs, proven. | Met: exactly one dispatch per run, three runs total; D2 moved no served byte (sections 5 and 6). |
| vi | Log as a dated owner-authorized settings change with revert evidence. | This entry, registered in `docs/evidence/index.md`, with the revert evidence attached in this directory. |

Condition (vi) is also the owner grant for this register-entry push.

## 2. The change

| Action | UTC | Policy id | Exact name | Type |
| --- | --- | --- | --- | --- |
| ADD | 2026-10-29T17:56:37Z | **64824653** | `aep3-i2/cp12.7-manifest-symlink` | branch |
| ADD | 2026-10-29T17:56:37Z | **64824654** | `aep3-i2/cp21-freshness-selector` | branch |
| REMOVE | 2026-10-29T17:58:42Z | 64824653, 64824654 | - | - |

* Each addition was `POST /repos/ModernNomad-98/aegis-consumer-proof/environments/github-pages/deployment-branch-policies` with one exact branch name; the responses assigned the ids above (evidence: `A1-add-response-preselector.json`, `A1-add-response-selector.json`).
* Each removal was `DELETE .../deployment-branch-policies/{id}`, HTTP 204 with an empty body and exit 0 (evidence: `A2-B2-meta.json`, which records the removal start at 2026-10-29T17:58:42Z).
* The environment setting `deployment_branch_policy.custom_branch_policies = true` is unchanged, and the environment object (id `25619927949`, one protection rule id `70471288`) is byte-identical before and after: `environment-before.json` and `environment-after.json` are both 580 B with SHA-256 `7b9b5553b38a6ac64b33e3d0def424fd94806427f2d784be015eb0360d250738`.

## 3. Four readings

Endpoint: `GET /repos/ModernNomad-98/aegis-consumer-proof/environments/github-pages/deployment-branch-policies`.

| Reading | UTC | total_count | Policies (id / name / type) | Evidence |
| --- | --- | --- | --- | --- |
| **B1** before add | 2026-10-29T17:55:37Z | 1 | 64714655 / `main` / branch | `B1-policy-before.json`, `B1-meta.json` |
| **A1** after add | 2026-10-29T17:56:38Z | 3 | 64824653 / `aep3-i2/cp12.7-manifest-symlink` / branch; 64824654 / `aep3-i2/cp21-freshness-selector` / branch; 64714655 / `main` / branch | `A1-policy-after-add.json`, `A1-meta.json` |
| **A2** after removal | 2026-10-29T17:58:43Z | 1 | 64714655 / `main` / branch | `A2-policy-after-remove.json`, `A2-B2-meta.json` |
| **B2** re-read after removal | 2026-10-29T17:58:43Z | 1 | 64714655 / `main` / branch | `B2-policy-reread.json`, `A2-B2-meta.json` |

Corroborating readings, same endpoint:

| Reading | UTC | total_count | Evidence |
| --- | --- | --- | --- |
| B1b immediately pre-add | 2026-10-29T17:56:36Z | 1 | `B1b-policy-immediately-before-add.json` |
| FINAL after all dispatches | 2026-10-29T18:01:46Z | 1 | `FINAL-policy-read.json`, `FINAL-meta.json` |
| SUSTAINED at record time | 2026-10-29T18:06:20Z | 1 | `SUSTAINED-policy-read.json`, `SUSTAINED-meta.json` |

**Byte-identity.** B1, B1b, A2, B2, FINAL and SUSTAINED are the same 138-byte
document, SHA-256 `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4`: `total_count` 1 with the single policy object id
64714655, name `main`, type `branch`. A2 and B2 are therefore byte-identical to B1, so the
return to the before state is literal, not merely structural. A1 is 390 B
(SHA-256 `c953bb532ec3fa82f45639596346c8a99c718b3e8530e9add98742a17a32a1ea`) and is exactly B1 plus the two added objects. The machine
summary records `B1b_equals_B1`, `A1_equals_B1_plus_two`, `A2_equals_B1`, `B2_equals_B1` and
`FINAL_equals_B1` all true (`summary.json`).

## 4. Deadline compliance (condition iv)

| Marker | UTC |
| --- | --- |
| Policy change (first POST) | 2026-10-29T17:56:37Z |
| Hard deadline (+60 min) | 2026-10-29T18:56:37Z |
| Removal started | 2026-10-29T17:58:42Z |
| Policy back to its before state (A2) | 2026-10-29T17:58:43Z |
| Time under change | **2 min 6 s** |
| Margin to deadline | 57 min 54 s |

No failure occurred mid-way, so the "revert FIRST" branch was not needed; the revert was
executed immediately after the second dispatch regardless, and before the restore dispatch.

## 5. Dispatches that used the temporary admission

Exactly one dispatch per run, three runs total, each `run_attempt = 1`; none was retried.

| Run | Ref @ SHA | Inputs | Dispatched (run created), UTC | Conclusion | Deployment | Served after |
| --- | --- | --- | --- | --- | --- | --- |
| **D1 fail-before** `40926181149` | `aep3-i2/cp12.7-manifest-symlink` @ `5cbd60a3da26b7168bfd891308fc4fc9b6ed70cf` | `mode=deploy`, `release=A` | 17:57:06Z (17:57:07Z) | **success** | `7420139651`, success 17:57:34Z, `environment_url` set | **A** `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` |
| **D2 pass-after** `40926362502` | `aep3-i2/cp21-freshness-selector` @ `42c39289c46ce65e08828c18a7e76e65598bc3e1` | `mode=deploy`, `release=B` | 17:58:16Z (17:58:17Z) | **failure**, by design: `freshness_selector_refused reason=selected_release_differs_from_live`; steps 6-8 skipped, no upload, no publish | object `7420165915`, failure 17:58:29Z, no `environment_url`, not a publish | **A** `12ad18e1...867c`, unchanged |
| **Restore** `40926519791` | `main` @ `f3ec2cff2e77a4c87049b2d428ce7bc4f99fa228` | `mode=deploy`, `release=B` | 17:59:17Z (17:59:19Z) | **success**, `freshness_selector_allow reason=ref_is_main` | `7420187769`, success 17:59:37Z, `environment_url` set | **B** `36bc4407514265db0bd0fcaa9dde87ad2db18373ed5646fd178ec97af5a9ba4a` |

Evidence: `D1-run.json`, `D2-run.json`, `restore-run.json`,
`steps-40926181149.json`, `steps-40926362502.json`, `steps-40926519791.json` and the machine
summary `summary.json`. D1 published stale release A over live B - the fail-before observation;
D2 was refused before upload or publish - the pass-after observation.

## 6. Served release restored byte-identical

Each snapshot is an independent HTTPS fetch of the three served files, hashed exactly as the
committed manifest serializes them (`name<TAB>bytes<TAB>LF<TAB>sha256`, sorted by name).

| Step | UTC | Aggregate | Notes |
| --- | --- | --- | --- |
| Before, **B** | 2026-10-29T17:56:09Z | `36bc4407514265db0bd0fcaa9dde87ad2db18373ed5646fd178ec97af5a9ba4a` | start state |
| After D1, **A** | 2026-10-29T17:58:08Z | `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` | stale release published |
| After D2, **A** | 2026-10-29T17:59:06Z | `12ad18e157ee0ed91ff174465d0adf65cca3430a6a29836d363b885c48bb867c` | unchanged; no byte moved |
| After restore, **B** | 2026-10-29T18:00:06Z | `36bc4407514265db0bd0fcaa9dde87ad2db18373ed5646fd178ec97af5a9ba4a` | end state |

Per-file values for the before and after-restore rows (identical in both):

| File | Bytes | LF | SHA-256 |
| --- | --- | --- | --- |
| `app.js` | 11776 | 452 | `4ae8bf8ede12a97627c63696f4b99172ba9cdbead519696a282035c4eab8d733` |
| `index.html` | 1666 | 42 | `27d54db89978ea1e9677ac953689a04ed077991f6dc35cf00a713e413fc385a2` |
| `styles.css` | 3914 | 252 | `94c4ee228c4e192c07e1794e6abe957bd3506a66235e8573842d39a4cf8b84f8` |

* `afterD2_bytes_identical_to_afterD1`: D2 moved no byte.
* `restored_bytes_identical_to_before`: the after-restore serialized rows equal the before rows byte for byte, so served B is byte-identical to the before snapshot, not merely equal in aggregate.
* The before and after-restore rows equal the committed release B manifest (`manifest-B.txt`, 363 B, SHA-256 `112edb0b3bfe469a5674aefbd3b74e8bc65baed02ef8aa07adea966aa62ca891`), whose aggregate line is `36bc4407...a4a`; the after-D1 and after-D2 rows equal the committed release A manifest (`manifest-A.txt`, 363 B, SHA-256 `897e222abcfc7a0fdbd5bc4c6df1933ff3e86364ba513810f4d5eb071ebe4479`), aggregate `12ad18e1...867c`. Full per-file digests are in `live-before.json`, `live-after-D1.json`, `live-after-D2.json` and `live-after-restore.json`.

## 7. Revert evidence attached

| Evidence | File | Bytes | SHA-256 |
| --- | --- | --- | --- |
| Policy before the change (B1) | `B1-policy-before.json` | 138 | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` |
| Policy immediately pre-add (B1b) | `B1b-policy-immediately-before-add.json` | 138 | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` |
| Add response, pre-selector ref | `A1-add-response-preselector.json` | 127 | `633af774bf2a3196eb5e2258f60a0504cf833956e0123f1cb84440741820df94` |
| Add response, selector ref | `A1-add-response-selector.json` | 127 | `31aca58a7cae6cd72e23255cb7b88a5d229021cb9c2bfe34d1f79a493f261a7d` |
| Policy with the two refs (A1) | `A1-policy-after-add.json` | 390 | `c953bb532ec3fa82f45639596346c8a99c718b3e8530e9add98742a17a32a1ea` |
| DELETE calls (HTTP 204) and timestamps | `A2-B2-meta.json` | 186 | `0adbf08dbcb78d09f0d7e8faba97d0dab8c3dbcff8c8b238e71511b3cd092774` |
| Policy after removal (A2) | `A2-policy-after-remove.json` | 138 | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` |
| Re-read after removal (B2) | `B2-policy-reread.json` | 138 | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` |
| Post-run confirmation (FINAL) | `FINAL-policy-read.json` | 138 | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` |
| Sustained read at record time | `SUSTAINED-policy-read.json` | 138 | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` |
| Environment before / after (identical) | `environment-before.json`, `environment-after.json` | 580 | `7b9b5553b38a6ac64b33e3d0def424fd94806427f2d784be015eb0360d250738` |
| D1 run | `D1-run.json` | 2458 | `24cf43bd49be4ddd9a6820b4d659e445b0b4e06dd9efd593dcd4f09db3fb7c58` |
| D2 run | `D2-run.json` | 2664 | `43c625088b4d2df6d92424d0a11b569b3382dd692d8aed3559f1b6ad7e65aef7` |
| Restore run | `restore-run.json` | 2539 | `5dee75a0520370f5a300d795da6d0cae77c4b8307fd59b88fd1e613c5748085d` |
| D1 steps | `steps-40926181149.json` | 3538 | `0091e699e6247d36744b5eb6672a4e29d0eba4af70f21f4cc0ef452c6d33c192` |
| D2 steps | `steps-40926362502.json` | 3746 | `dbb851077f7653388710f68ca86dba2ecfa2251b66a11f0fa3551e2f671b75df` |
| Restore steps | `steps-40926519791.json` | 3692 | `efac09fe6fd1a16d87e8fea6fc424cafde7f15b5065ce51e4a99d76b90665059` |
| Machine summary (all checks true) | `summary.json` | 5554 | `675b348ed7d1e9eefbeb7068c89d2e000c1c11534c74304c7e82c4daae2e494c` |
| Served, before | `live-before.json` | 1675 | `b974a88ef9f43356f79fc3d3a8aa2f08f739eecb6f09b50805161254b4759c7a` |
| Served, after D1 | `live-after-D1.json` | 1683 | `4d711a43d712a74e5bec183127ca02d18dbae813080e7f99d51f5f0957d330f4` |
| Served, after D2 | `live-after-D2.json` | 1683 | `972a2eb4b2915d174835084d452c298cedba8fded2bc47d43d01eb195202b7f0` |
| Served, after restore | `live-after-restore.json` | 1703 | `c68752bed305e34b78b3c4c92c5a71a1f3845c9d5b66d5a697fc685ae7244996` |
| Committed manifest A | `manifest-A.txt` | 363 | `897e222abcfc7a0fdbd5bc4c6df1933ff3e86364ba513810f4d5eb071ebe4479` |
| Committed manifest B | `manifest-B.txt` | 363 | `112edb0b3bfe469a5674aefbd3b74e8bc65baed02ef8aa07adea966aa62ca891` |

The attached JSON captures are committed byte-for-byte, including the CRLF line endings
produced by the provider capture commands; this directory sets `-text` so those bytes are not
normalised. The hashes above and in `EVIDENCE-INDEX.md` are therefore also the hashes of the
execution evidence they were copied from, and they are the binding values for the committed
bytes.

## 8. Scope discipline

* Exactly two named refs, one per branch, by exact name; no wildcard, no all-branches entry, no tag policy, no other environment, no other setting, and no secret or permission change.
* No retry: every run has `run_attempt = 1`.
* No Pages disable or unpublish; no branch-protection change.
* No main-ref dispatch of stale A as a "control": it would have deployed A and changed served content outside the authorized pair, and the execution record's section 2.1 already settles the question from the committed selector bytes.
* This registration is docs only: it adds this directory and one row in `docs/evidence/index.md`; it changes no code, README or workflow and triggers no workflow run (`pages.yml` is `workflow_dispatch` only).

## 9. Register binding

Registered in `docs/evidence/index.md` under `## Settings changes`, in the same form as the
other evidence records: the row binds this file by SHA-256, byte count and LF count over the
committed bytes. `EVIDENCE-INDEX.md` in this directory binds the 29 attached evidence
files the same way.

## 10. Record

| Field | Value |
| --- | --- |
| Settings change | CP-21(B), SDP-1 section 1 item 6 class |
| Date | 2026-10-29 (UTC and America/Los_Angeles) |
| Owner | Peter (`ModernNomad-98`) |
| Source class | owner decision CP-21=B, condition (vi), carried by the CP-21(B) execution brief |
| Repository / environment | `ModernNomad-98/aegis-consumer-proof` / `github-pages` |
| Policy | id `64714655`, name `main`, type `branch` |
| Change window | 2026-10-29T17:56:37Z to 2026-10-29T17:58:43Z, 2 min 6 s |
| Final policy state | equal to the before state; A2 and B2 byte-identical to B1 |
| Registration | `docs/evidence/index.md`, `## Settings changes` |
| Evidence | this directory, 29 attached files plus `EVIDENCE-INDEX.md` |

## 11. UNRUN

None for the settings change or for this registration. The one deliberately unrun item is the
main-ref stale-A control, for the reason in section 8; the row does not require it.

**Model line:** deepseek-flash via DeepSeek Harness, 2026-10-29.
