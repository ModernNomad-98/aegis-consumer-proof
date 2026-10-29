# Consumer install record — installed starter at pin `ffb040c7`

**Record type:** install record for this repository. It records a root install that has already
been performed on a non-main branch; it is not an instruction to publish or deploy.

| field | value |
| --- | --- |
| Repository | `ModernNomad-98/aegis-consumer-proof` (public) |
| Branch | `aep3-i2/startup-readback` (new, non-main) |
| Parent commit | `7954d8a346510c9dc17d4ed5b4d531b342a9d797` (the pinned vendor commit) |
| Base of that vendor commit | `390363f66c72f81834b9d910b6859ff82ea45bda` (= `main` at the provider, unchanged) |
| Installed source | Project Aegis installed starter, pin `ffb040c7a363648856475280646bbd142dfabe4e` |
| Source tree at the pin | `88a5aee4ad928a49c2fb945032585843ec652da7` |
| Vendor copy (source of the copy) | `docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7/` |
| Vendor commit tree | `da605a39ecaa65ccc006e93cba4c1e9d7602d84f` |
| Install destination | repository **root**: `AGENTS.md`, `CLAUDE.md`, `.claude/skills/**` |
| Files installed | **41** |
| Total bytes | **369,093** |
| Aggregate (41-row serialisation) | `fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699` over **5,420** bytes |
| Edits to the bytes | **none** — proven by blob identity below, not by inspection |

This file is committed in the same commit as the 41 installed files. A file cannot carry the id
of the commit that adds it, so the commit id, tree and the machine identity table are recorded
outside this repository, in the replication record and its evidence set.

---

## 1. Pre-install comparison row

Read before any file was written, at the parent commit:

| check | reading |
| --- | --- |
| Files tracked at the parent commit | 65 (19 repository files + 46 files in the pinned vendor directory) |
| `AGENTS.md` at the parent commit | absent at the root |
| `CLAUDE.md` at the parent commit | absent at the root |
| `.claude/` at the parent commit | absent at the root |
| Worktree before the install | clean (`git status --porcelain` empty) |
| `core.autocrlf` | `true` |
| `core.eol` | unset |
| `.gitattributes` | `* text=auto eol=lf` |
| Root-path collisions | none; no installed path was overwritten |

The install therefore **added** 41 root paths and replaced nothing.

## 2. Line-ending measurement at install time

| check | reading |
| --- | --- |
| `git ls-files --eol` over the 41 paths | 41 / 41 `i/lf` and `w/lf`, attr `text=auto eol=lf` |
| CRLF in any installed file | 0 / 41 |
| Byte counts and LF counts vs the manifest | 41 / 41 equal |
| Staged blob id vs vendor blob id | 41 / 41 equal |
| Staged blob id vs source-pin blob id | 41 / 41 equal |

Raw reading: the `git ls-files --eol` dump in the replication evidence set (outside this
repository).

## 3. The 41 installed rows

LF = count of `0x0A` bytes. SHA-256 is of the installed bytes. Blob = Git blob id shared by
the vendor copy, the source pin and the installed root file.

| Path (repository root) | Bytes | LF | SHA-256 | Blob |
| --- | ---: | ---: | --- | --- |
| `.claude/skills/agent-startup-context-gate/SKILL.md` | 21,084 | 336 | `a157d30d5b8eac48243906d2e46716e6bc37a0591e648b062a0430f7da3c35ee` | `c42b5cd7dc0968c96cc9a1b4c9e6e36f79de993f` |
| `.claude/skills/agent-startup-context-gate/references/context-source-checklist.md` | 3,325 | 59 | `79383159c3b45357eb9a236eb0d984b784f35362f5ac40ce1f6083c3acfb8563` | `ccd79e9b1be9b10c56d3cfe4579f09ff695db2fc` |
| `.claude/skills/agent-startup-context-gate/references/shared-local-resource-coordination.md` | 16,797 | 297 | `b3cc865f02d2a1042252939d21eb7c27805fe48b7e0637de70c361be99fee9a8` | `05ef36c4a36e7f6931a23461115b027306284fca` |
| `.claude/skills/ai-sdlc-operating-model/SKILL.md` | 9,650 | 167 | `604e4d5aee14a88ec124a369fd4f7600d049e42bfef49f780cf858086426682e` | `1d63e183dd1d64794f7c83b65e6197a702635f19` |
| `.claude/skills/ai-sdlc-operating-model/references/stage-gate-map.md` | 5,596 | 65 | `9f17997c2a0d5fdd68138e9620a1f1c07060a93022974e710a6f62f6a1d901f8` | `edd481a789498c64a526ac1286b43d3ad2a366be` |
| `.claude/skills/architecture-designer/SKILL.md` | 8,491 | 158 | `a6f56df1da1ed960d057290c905766fcd1a8266cd7cb13a0185d095ab342ec33` | `fefbfb2ceaa4366877d9f5591cf2ba03ce7cf732` |
| `.claude/skills/architecture-designer/references/architecture-artifacts.md` | 3,110 | 66 | `e5c6d07ffb1479f7e048b41f515f2131f40480027836dbfe594d280262b0891e` | `4aba5531fab70c8b8bc486c02df6411eea835191` |
| `.claude/skills/change-classification-gate/SKILL.md` | 7,185 | 141 | `08d91a834460beebc9c66fa896b8b422f064bf1d7524f6e5b1512cda3afdc996` | `3b3e9493296825a7572eac9438f54189b7d6467f` |
| `.claude/skills/change-classification-gate/references/classification-matrix.md` | 3,781 | 49 | `0362e2eebc11b1a7d35282c8deec6d29021433f847782965e08ceac43906c7b4` | `33226d8b096d7c0ba632167af720ad13d1f96e23` |
| `.claude/skills/code-reviewer/SKILL.md` | 9,404 | 165 | `6238b67b7b90fcbb26fcc45300562efa9e290a9d3870548e37bedaabbc76449a` | `dda01e34b0dcc8c49e3cc5ad9f51cd6354a853ca` |
| `.claude/skills/code-reviewer/references/severity-rubric.md` | 5,151 | 86 | `017c223f84cb49a57211e5d1096b9e9210a135c51419db1ea423ef05f26fb491` | `460a4c6c9ee25f3ca13904035eba9bb77cd2e8ff` |
| `.claude/skills/domain-modeler/SKILL.md` | 7,031 | 129 | `4001c1edff7ed32025f31e4d69c656ad2610a2fd0a12aade2fb25adc49e09c37` | `262bc6b82d6ff56fce7ad45ab98afcbf80ea3ae8` |
| `.claude/skills/domain-modeler/references/domain-artifacts.md` | 3,737 | 77 | `eb62149495d685c8f3fa6475da65d94d15ca0dce6714d9af37a7a64974426535` | `ed9b715ac3be9fa98ac47b3d8dca13f038b77290` |
| `.claude/skills/human-approval-boundary/SKILL.md` | 8,301 | 146 | `4efcb7251333c9da12b1d1909c4a7e0d7c09de73220e230519cceadb6af648a8` | `35923a767254037dda45b9394a8c89e936822ab6` |
| `.claude/skills/human-approval-boundary/references/consumer-manual-only-policy.md` | 3,764 | 35 | `cd719096fef8fc2f4384122709f882265f62d38b9e9359647a57e27c03d8f33d` | `9153c33819319403f1021c1f3c7c285657fb7429` |
| `.claude/skills/phased-work-handoff-designer/SKILL.md` | 10,070 | 175 | `12e0caf60ec50d75b6370292e027b3926caddeecd2c77cd51a58d33e817984d4` | `56fcddce1e006ff7055a3c1bf5ad17d0509ace70` |
| `.claude/skills/phased-work-handoff-designer/references/handoff-sheet.md` | 2,433 | 80 | `d976510390adc6aec332bc3b19b80ece7692e2ec1e9025108a0b9340307e09fe` | `e7ce73271a53830c318ea6ef7a25aadc279e64f1` |
| `.claude/skills/plan-audit-reviewer/SKILL.md` | 7,353 | 72 | `e055fce01fc55371c331ce71af4b0721397d78ec1ba2ca2fe013899846b1af86` | `1df7d253dcae6ad3db964c7c0d13f0c3488441ff` |
| `.claude/skills/plan-audit-reviewer/references/plan-audit-checklist.md` | 2,299 | 25 | `27928bd205d5b5a4c57caacce72b481c2b9841f5b8ce01e97c9da18c97550fb3` | `e419430b876d4929f0e6ce947e27894e6a202a2c` |
| `.claude/skills/plan-of-record-author/SKILL.md` | 6,244 | 71 | `86d2d6e3d52ad96d9f165041a6219c0d0bbce39d1c352b523f0c4ad2dd697634` | `4801232935ac02614f0c9b314f1d79325af48efa` |
| `.claude/skills/plan-of-record-author/references/plan-of-record-package.md` | 1,973 | 25 | `a2509f23892bf16eb43bbe1130bc4ac5eb2221bb5f529252e141c34290e492be` | `93a59c01e300c9f238f2b3110beb895e2ae66d8b` |
| `.claude/skills/product-spec-writer/SKILL.md` | 13,519 | 234 | `a8fef31f8992436dd2fb75cf9575b293373dda45362fa950481573299d1185cc` | `b625b2fa27d8e12057ceeaecaad9ac170a4d19fb` |
| `.claude/skills/product-spec-writer/references/product-spec-sheet.md` | 3,940 | 111 | `1452cb673884eb106f73a2e0221a17de1d1fd9b30b2c87b841355f7e4fc8c993` | `54668786dcb6680f815cfff960f858e7d55eef9a` |
| `.claude/skills/project-orchestrator/SKILL.md` | 42,794 | 494 | `3ef1f0ba8b350385aaf5b0a2929c38d2e3f24c176875635129fa139ef22f0584` | `dfcf9f3bb74f2a442362207d4582aee1a41e1a0e` |
| `.claude/skills/project-orchestrator/references/project-state-template.md` | 22,454 | 357 | `902f982e9b1314f644aa341319c129757c5461c606edbda8264943c5de4e22d5` | `4c9b3d68307305a2be949e9a0c7cdd40eb5bc9ac` |
| `.claude/skills/project-orchestrator/references/recording-and-authority.md` | 10,024 | 180 | `bdcf2bb67f27f8b617566f7c44cd9d3223cc064baa2f4a73b2856398db7cdaa1` | `9ed5b7af0740104a358f6acc6b7cec0e02f8526a` |
| `.claude/skills/release-readiness-reviewer/SKILL.md` | 10,663 | 192 | `9d1cd8091385e537f823c6b8d78be4b180f2599fc354129ec8f735389dd5d305` | `5860f45d2ef794cb5ed34fe3f61617695ee1d8a8` |
| `.claude/skills/release-readiness-reviewer/references/readiness-evidence.md` | 3,645 | 48 | `d03ee7b15768ee0498024bedbce58a98f9d2c8201cb6be23128be9e8bccc71ca` | `d3af07864836e7d4e25124ce7d605e46b5d37fba` |
| `.claude/skills/requirements-gathering-facilitator/SKILL.md` | 16,061 | 271 | `db5c6795ae85bbf07faa5a791702e76edf09a0305399600f56d34975029b8c37` | `99f9b19bdfb0c3da2b04d49435dbc28224873f9d` |
| `.claude/skills/requirements-gathering-facilitator/references/elicitation-sheet.md` | 6,524 | 174 | `fbd4f381627d19b6f406458644fb27305cdb5169c5b3e9f6f66c1779378aea7b` | `21f45e89555c05f58e68b2e562ab9e6c1496560c` |
| `.claude/skills/scoped-approval-register/SKILL.md` | 11,822 | 193 | `a74d2a22579cf93f737725aa0c54197b5d496a9f33a291a93c2cf2073cd7d076` | `c317530454301c32b1bd8a39f52ed968fa9c65f2` |
| `.claude/skills/scoped-approval-register/references/register-format.md` | 7,518 | 136 | `ace0fb62e81df2e0a7a28822c67426d23cd0938ee6cfa7cfa6665c41e80521b6` | `8a20678755798334346d16fd41f8b404ea08c9b0` |
| `.claude/skills/screenshot-evidence-planner/SKILL.md` | 10,878 | 183 | `b0910f9003a3479d7753f4da608dfd9b275ab8ca5d0157c7adb8e5d8813a8c1f` | `e88ad371a74a2fe72d5254041aaf785e6e66c773` |
| `.claude/skills/screenshot-evidence-planner/references/evidence-rules.md` | 3,389 | 66 | `d7a06498ddfcb31798efa5d35f966121ec089b31882805b7bb4b73ac7b9f85d7` | `b0db745fe67523f7afd9b35b5837aaca3368b7af` |
| `.claude/skills/tech-spec-writer/SKILL.md` | 10,865 | 191 | `cd1ee59dc53452de93404ceb2c1afdea49f64d2a1576dd1ba3621d93da3806f5` | `dfb04a2c24a3a0bda1efa3ec9fd595f574aa3325` |
| `.claude/skills/tech-spec-writer/references/tech-spec-sheet.md` | 2,935 | 72 | `d7c7757942fc9a9e954fa241d595c95339b20f9c531eab8a00572550f4c99323` | `c04840c7ea8d9553c6ede5b21b8991d82358a457` |
| `.claude/skills/test-plan-designer/SKILL.md` | 9,662 | 158 | `beba751405cd1cccc7dd1a3c5c9f26a833dc192e4ca08a8eb163d8db333713ba` | `86acd57e8eb75f34726a49508892325af7e49aaf` |
| `.claude/skills/test-plan-designer/references/qa-scenario-extensions.md` | 2,450 | 32 | `16058d2721a57c3e74c8175b9c627307a50a3f5678e311a44cf51b599b32ef4b` | `4e066fd7c3bb5f013471226ce10f1251a1e899af` |
| `.claude/skills/test-plan-designer/references/test-plan-template.md` | 5,256 | 77 | `d2561d221cf018875f5b044284e0dc0f3476a42741a7818af83d765896e70e53` | `823d4e8e0bac8ab06255dbc6470d779ae85476c1` |
| `AGENTS.md` | 25,228 | 231 | `02628bd7a224ec8dbb1534baccbc18fe1f805b225f644d49b0003b1d42d862fc` | `e45a953106815ab4af7c48339dc3cac41f550ea2` |
| `CLAUDE.md` | 2,687 | 17 | `760afd104f1b058cfe08dac6cf2648c5391eace1db5e7cd86ee7ed6cd8cafb6c` | `515fd3d36341f219000ae21dd96b9c51b17d377b` |

## 4. Identity — why "no edits" is a proof and not a claim

The copy was not made from a working checkout. Each row's bytes were extracted with
`git cat-file blob` from the **pinned blob id stored in the vendor commit**, written to the
root path, re-hashed from disk, staged, and then compared as a staged blob id:

| stage | comparison | result |
| --- | --- | --- |
| 1 | vendor blob id vs source-pin blob id (`ffb040c7:<path>`) | 41 / 41 equal |
| 2 | installed file SHA-256 vs `HASH-MANIFEST.tsv` row | 41 / 41 equal |
| 3 | installed file re-read from disk vs manifest | 41 / 41 equal |
| 4 | staged index blob vs vendor blob | 41 / 41 equal |
| 5 | staged paths outside the 41 install paths | 0 |
| 6 | row serialisation recomputed from the installed bytes | 5,420 bytes, `fcff1124…b699` — equals the pin's published aggregate |

Drift = **0**. A local edit anywhere in the 41 files would have broken stage 1 or stage 4.

## 5. The pinned vendor copy is retained

The root install does not replace the vendor copy. Both exist on this branch:

| copy | path | role |
| --- | --- | --- |
| vendor (pinned) | `docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7/` | source of truth, with `HASH-MANIFEST.tsv`, `HASH-MANIFEST.md`, `LICENSE`, `NOTICE`, `README.md` |
| installed (root) | `AGENTS.md`, `CLAUDE.md`, `.claude/skills/**` | the bytes a fresh consumer session reads |

`HASH-MANIFEST.tsv` in that directory hashes to `fcff1124…b699` (5,420 bytes), so the manifest
that defines the 41 rows is in the repository and is checkable with one command. Deleting the
vendor copy would remove the only in-repository record of the pin, the manifest and the
attribution; it is intentionally kept.

## 6. Attribution and licence

The installed bytes are unmodified Apache-2.0 material from Project Aegis. Attribution travels
with them inside this repository, in the pinned vendor directory:

| file | SHA-256 | what it states |
| --- | --- | --- |
| `…/pin-ffb040c7/LICENSE` | `c71d239df91726fc519c6eb72d318ec65820627232b2f796219e87dcf35d0ab4` | Apache License 2.0, verbatim |
| `…/pin-ffb040c7/NOTICE` | `d9b896ca5832596f0ca12ffb91ca9d70933d3891637f966d52ad29d26e4c753f` | source project, pin, tree and the unmodified-bytes statement |

No new licence claim is made over the consumer repository's own content, and the installed
bytes are not edited, so no licence header is added to them.

## 7. Path deviation from the plan — recorded, not hidden

The plan's Tree 1 puts the guidance at the repository root and its evidence tree has no
`consumer-readiness/` subtree. The vendor turn deliberately placed the pinned bytes under
`docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7/` and deferred the root install
to this turn. This record closes that deviation: the plan's root install now exists, and the
vendor path is retained as the pinned source above it.

Two paths now carry the same 41 blobs. That is deliberate: one is the install, the other is
the pin and manifest. A future drift check must compare **blob ids across both**, not file
contents of one against the other.

## 8. How to reproduce the install

```sh
git clone https://github.com/ModernNomad-98/aegis-consumer-proof.git
cd aegis-consumer-proof
git checkout aep3-i2/startup-readback

# 1. the pin and the 41 canonical rows
sha256sum docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7/HASH-MANIFEST.tsv
# expect fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699

# 2. every installed root blob equals the pinned source blob
git clone https://github.com/ModernNomad-98/Project-Aegis.git /tmp/aegis-src
cd /tmp/aegis-src && git checkout ffb040c7a363648856475280646bbd142dfabe4e && cd -
while IFS=$(printf '\t') read -r p b l h; do
  a=$(git rev-parse "HEAD:$p"); c=$(git -C /tmp/aegis-src rev-parse "ffb040c7a363648856475280646bbd142dfabe4e:$p")
  [ "$a" = "$c" ] || echo "DRIFT $p"
done < docs/evidence/consumer-readiness/installed-starter/pin-ffb040c7/HASH-MANIFEST.tsv
```

## 9. Limits

- This record is evidence of an install, not of consumer behaviour. Startup readback, routing
  and recovery are separate observations (CP-05 / CP-07 / CP-18) recorded outside this
  repository.
- The install was performed by an agent, not by a human installer; the human-installer case is
  a different record.
- No merge, no pull request, no workflow dispatch, no deploy and no settings change followed
  from this install.
- The negative install probes (missing reference, changed byte, stale pin, collisions) are
  recorded in the installer's evidence set and are not repeated here.
