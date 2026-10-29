# Evidence index - CP-21(B) settings change, 2026-10-29

SHA-256 values are computed over the exact committed bytes (no BOM). The JSON
captures retain the CRLF line endings of the provider capture commands; the two
Markdown files and the two manifest captures use LF. This directory sets
`* -text` so every attached byte is committed unchanged.
Each entry binds one file; if a file changes, its entry must be recomputed.
The register row is in `docs/evidence/index.md` under `## Settings changes`.

| Artifact | SHA-256 | Bytes | LF | Note |
| --- | --- | --- | --- | --- |
| `CP-21-SETTINGS-CHANGE-20261029.md` | `bc07e378bc3eebaba5fa9654f2a764af253bc28aa93465210b923a84c7a2be5f` | 15860 | 199 | The dated owner-authorized settings-change record (this entry). |
| `A1-add-response-preselector.json` | `633af774bf2a3196eb5e2258f60a0504cf833956e0123f1cb84440741820df94` | 127 | 1 | POST response assigning policy id 64824653. |
| `A1-add-response-selector.json` | `31aca58a7cae6cd72e23255cb7b88a5d229021cb9c2bfe34d1f79a493f261a7d` | 127 | 1 | POST response assigning policy id 64824654. |
| `A1-meta.json` | `7ce21a42209fafe04fddb1b307f15f52c22082353dfd12456a68de3de72ccc4f` | 211 | 8 | A1 and pre-add timestamps (17:56:36Z to 17:56:38Z). |
| `A1-policy-after-add.json` | `c953bb532ec3fa82f45639596346c8a99c718b3e8530e9add98742a17a32a1ea` | 390 | 1 | A1 policy reading after the add: total_count 3. |
| `A2-B2-meta.json` | `0adbf08dbcb78d09f0d7e8faba97d0dab8c3dbcff8c8b238e71511b3cd092774` | 186 | 7 | DELETE start (17:58:42Z) and A2/B2 read timestamps (17:58:43Z). |
| `A2-policy-after-remove.json` | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` | 138 | 1 | A2 policy reading after removal; byte-identical to B1. |
| `B1-meta.json` | `ef7bef77f855b9159c442b4e855f24d08c5a3b73572fc438bdce28f7acb2c150` | 94 | 5 | B1 reading timestamp (17:55:37Z). |
| `B1-policy-before.json` | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` | 138 | 1 | B1 policy reading before the add: total_count 1, policy 64714655 main. |
| `B1b-policy-immediately-before-add.json` | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` | 138 | 1 | B1b confirmation reading immediately before the add (17:56:36Z). |
| `B2-policy-reread.json` | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` | 138 | 1 | B2 re-read after removal; byte-identical to B1. |
| `D1-run.json` | `24cf43bd49be4ddd9a6820b4d659e445b0b4e06dd9efd593dcd4f09db3fb7c58` | 2458 | 1 | D1 run 40926181149 (success), job and steps. |
| `D2-run.json` | `43c625088b4d2df6d92424d0a11b569b3382dd692d8aed3559f1b6ad7e65aef7` | 2664 | 1 | D2 run 40926362502 (failure at the freshness selector). |
| `FINAL-meta.json` | `dfc7a8f2144d3e05da46fd42d471a27b9490d77b7cd27947008cc66c0c87a599` | 96 | 5 | FINAL read timestamp (18:01:46Z). |
| `FINAL-policy-read.json` | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` | 138 | 1 | Post-dispatch confirmation reading; byte-identical to B1. |
| `SUSTAINED-meta.json` | `888559bea0694deedeb077f3a749346bfb8d76de7cc67bba604cbc5c98352208` | 76 | 4 | SUSTAINED read timestamp (18:06:20Z). |
| `SUSTAINED-policy-read.json` | `692c625be6132ce93db1b3020c2945074bdff433178df8e2e88af9e34df7e3a4` | 138 | 1 | Sustained reading at record time; byte-identical to B1. |
| `environment-after.json` | `7b9b5553b38a6ac64b33e3d0def424fd94806427f2d784be015eb0360d250738` | 580 | 1 | Environment object after the change; identical to before. |
| `environment-before.json` | `7b9b5553b38a6ac64b33e3d0def424fd94806427f2d784be015eb0360d250738` | 580 | 1 | Environment object before the change. |
| `live-after-D1.json` | `4d711a43d712a74e5bec183127ca02d18dbae813080e7f99d51f5f0957d330f4` | 1683 | 50 | Served snapshot after D1: A, aggregate 12ad18e1. |
| `live-after-D2.json` | `972a2eb4b2915d174835084d452c298cedba8fded2bc47d43d01eb195202b7f0` | 1683 | 50 | Served snapshot after D2: A unchanged, byte-identical to after-D1. |
| `live-after-restore.json` | `c68752bed305e34b78b3c4c92c5a71a1f3845c9d5b66d5a697fc685ae7244996` | 1703 | 50 | Served snapshot after restore: B, byte-identical to before. |
| `live-before.json` | `b974a88ef9f43356f79fc3d3a8aa2f08f739eecb6f09b50805161254b4759c7a` | 1675 | 50 | Served snapshot before the change: B, aggregate 36bc4407. |
| `manifest-A.txt` | `897e222abcfc7a0fdbd5bc4c6df1933ff3e86364ba513810f4d5eb071ebe4479` | 363 | 4 | Committed release A manifest; aggregate 12ad18e1. |
| `manifest-B.txt` | `112edb0b3bfe469a5674aefbd3b74e8bc65baed02ef8aa07adea966aa62ca891` | 363 | 4 | Committed release B manifest; aggregate 36bc4407. |
| `restore-run.json` | `5dee75a0520370f5a300d795da6d0cae77c4b8307fd59b88fd1e613c5748085d` | 2539 | 1 | Restore run 40926519791 (success), job and steps. |
| `steps-40926181149.json` | `0091e699e6247d36744b5eb6672a4e29d0eba4af70f21f4cc0ef452c6d33c192` | 3538 | 1 | D1 step list: upload and publish reached. |
| `steps-40926362502.json` | `dbb851077f7653388710f68ca86dba2ecfa2251b66a11f0fa3551e2f671b75df` | 3746 | 1 | D2 step list: selector failure, upload and publish skipped. |
| `steps-40926519791.json` | `efac09fe6fd1a16d87e8fea6fc424cafde7f15b5065ce51e4a99d76b90665059` | 3692 | 1 | Restore step list: all steps success. |
| `summary.json` | `675b348ed7d1e9eefbeb7068c89d2e000c1c11534c74304c7e82c4daae2e494c` | 5554 | 221 | Machine summary: policy checks and served aggregate chain, all checks true. |

Total: 30 artifacts (the record plus 29 attached evidence files).
