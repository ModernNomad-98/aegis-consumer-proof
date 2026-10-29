param(
  [Parameter(Mandatory)][string]$Src,
  [Parameter(Mandatory)][string]$Tgt,
  [string]$Sh = 'C:\Program Files\Git\bin\sh.exe',
  [string]$RecordPath
)
# Published P5-P9 harness for docs/consumer-starter-package.md (v2).
# Requires PowerShell 7. Failure paths write to stderr and exit; they never use
# Write-Error, so an inherited $ErrorActionPreference = 'Stop' cannot turn a
# documented exit code into exit 1.
$ErrorActionPreference = 'Stop'
$PinCommit = 'ffb040c7a363648856475280646bbd142dfabe4e'
$PinTree   = '88a5aee4ad928a49c2fb945032585843ec652da7'
$AggSha    = 'fcff1124d9d15e7d7230fd317350e0eb3b097b453bb6b911cdc1e2485525b699'
$AggRows   = 41
$AggBytes  = 5420

function Stop-Step([int]$Code, [string]$Message) {
  [Console]::Error.WriteLine(('exit {0}: {1}' -f $Code, $Message))
  exit $Code
}

$Tgt = [IO.Path]::GetFullPath($Tgt).TrimEnd([IO.Path]::DirectorySeparatorChar)
$Src = [IO.Path]::GetFullPath($Src).TrimEnd([IO.Path]::DirectorySeparatorChar)
if (-not (Test-Path -LiteralPath $Tgt -PathType Container)) { Stop-Step 1 "target not found: $Tgt" }
if (-not (Test-Path -LiteralPath $Src -PathType Container)) { Stop-Step 1 "source clone not found: $Src" }

# P4 - the 41-path package list, transcribed from section 2.3 (ordinal order).
$package = @(
  '.claude/skills/agent-startup-context-gate/SKILL.md'
  '.claude/skills/agent-startup-context-gate/references/context-source-checklist.md'
  '.claude/skills/agent-startup-context-gate/references/shared-local-resource-coordination.md'
  '.claude/skills/ai-sdlc-operating-model/SKILL.md'
  '.claude/skills/ai-sdlc-operating-model/references/stage-gate-map.md'
  '.claude/skills/architecture-designer/SKILL.md'
  '.claude/skills/architecture-designer/references/architecture-artifacts.md'
  '.claude/skills/change-classification-gate/SKILL.md'
  '.claude/skills/change-classification-gate/references/classification-matrix.md'
  '.claude/skills/code-reviewer/SKILL.md'
  '.claude/skills/code-reviewer/references/severity-rubric.md'
  '.claude/skills/domain-modeler/SKILL.md'
  '.claude/skills/domain-modeler/references/domain-artifacts.md'
  '.claude/skills/human-approval-boundary/SKILL.md'
  '.claude/skills/human-approval-boundary/references/consumer-manual-only-policy.md'
  '.claude/skills/phased-work-handoff-designer/SKILL.md'
  '.claude/skills/phased-work-handoff-designer/references/handoff-sheet.md'
  '.claude/skills/plan-audit-reviewer/SKILL.md'
  '.claude/skills/plan-audit-reviewer/references/plan-audit-checklist.md'
  '.claude/skills/plan-of-record-author/SKILL.md'
  '.claude/skills/plan-of-record-author/references/plan-of-record-package.md'
  '.claude/skills/product-spec-writer/SKILL.md'
  '.claude/skills/product-spec-writer/references/product-spec-sheet.md'
  '.claude/skills/project-orchestrator/SKILL.md'
  '.claude/skills/project-orchestrator/references/project-state-template.md'
  '.claude/skills/project-orchestrator/references/recording-and-authority.md'
  '.claude/skills/release-readiness-reviewer/SKILL.md'
  '.claude/skills/release-readiness-reviewer/references/readiness-evidence.md'
  '.claude/skills/requirements-gathering-facilitator/SKILL.md'
  '.claude/skills/requirements-gathering-facilitator/references/elicitation-sheet.md'
  '.claude/skills/scoped-approval-register/SKILL.md'
  '.claude/skills/scoped-approval-register/references/register-format.md'
  '.claude/skills/screenshot-evidence-planner/SKILL.md'
  '.claude/skills/screenshot-evidence-planner/references/evidence-rules.md'
  '.claude/skills/tech-spec-writer/SKILL.md'
  '.claude/skills/tech-spec-writer/references/tech-spec-sheet.md'
  '.claude/skills/test-plan-designer/SKILL.md'
  '.claude/skills/test-plan-designer/references/qa-scenario-extensions.md'
  '.claude/skills/test-plan-designer/references/test-plan-template.md'
  'AGENTS.md'
  'CLAUDE.md'
)
if ($package.Count -ne 41) { Stop-Step 31 "package list has $($package.Count) rows, expected 41" }
$skillDirs = @($package | Where-Object { $_ -like '.claude/skills/*' } |
  ForEach-Object { ($_ -split '/')[0..2] -join '/' } | Sort-Object -Unique)
if ($skillDirs.Count -ne 18) { Stop-Step 31 "package list yields $($skillDirs.Count) skill directories, expected 18" }

# P3 identity - the clone must be the pinned commit/tree and clean.
$head = (& git -C $Src rev-parse HEAD 2>$null | Out-String).Trim()
$tree = (& git -C $Src rev-parse 'HEAD^{tree}' 2>$null | Out-String).Trim()
$dirty = @(& git -C $Src status --porcelain 2>$null)
if ($head -ne $PinCommit) { Stop-Step 31 "source HEAD $head is not the pinned commit $PinCommit" }
if ($tree -ne $PinTree) { Stop-Step 31 "source tree $tree is not the pinned tree $PinTree" }
if ($dirty.Count) { Stop-Step 31 "source clone is not clean: $($dirty[0])" }

function Get-FileSha256([string]$Path) {
  $sha = [Security.Cryptography.SHA256]::Create()
  try { return ([BitConverter]::ToString($sha.ComputeHash([IO.File]::ReadAllBytes($Path)))).Replace('-','').ToLowerInvariant() }
  finally { $sha.Dispose() }
}
function Get-LfCount([byte[]]$Bytes) { return @($Bytes | Where-Object { $_ -eq 10 }).Count }
function Get-CrCount([byte[]]$Bytes) { return @($Bytes | Where-Object { $_ -eq 13 }).Count }

# P5 - destination pre-checks. An existing skill directory is accepted only as a
# resume of a prior partial install: every file already there must be one of that
# skill's packaged files and byte-identical to the pinned source.
foreach ($rel in $package) {
  if ($rel -match '(^|/)\.\.(/|$)') { Stop-Step 21 "unsafe source path $rel" }
  $srcPath = Join-Path $Src ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  if (-not (Test-Path -LiteralPath $srcPath -PathType Leaf)) { Stop-Step 21 "missing source file: $srcPath" }
  $segments = @(($rel -split '/') | Select-Object -SkipLast 1)
  $walk = $Src
  foreach ($seg in $segments) {
    $walk = Join-Path $walk $seg
    $parentItem = Get-Item -LiteralPath $walk -Force -ErrorAction Stop
    if ($parentItem.Attributes -band [IO.FileAttributes]::ReparsePoint) { Stop-Step 21 "reparse-point source segment: $walk" }
  }
  $leafItem = Get-Item -LiteralPath $srcPath -Force -ErrorAction Stop
  if ($leafItem.Attributes -band [IO.FileAttributes]::ReparsePoint) { Stop-Step 21 "reparse-point source: $srcPath" }
  $resolved = (Resolve-Path -LiteralPath $srcPath).ProviderPath
  $srcPrefix = $Src + [IO.Path]::DirectorySeparatorChar
  if (-not $resolved.StartsWith($srcPrefix, [StringComparison]::OrdinalIgnoreCase)) {
    Stop-Step 21 "source resolves outside the clone: $resolved"
  }
}
foreach ($rel in $skillDirs) {
  $dst = Join-Path $Tgt ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  if (-not (Test-Path -LiteralPath $dst)) { continue }
  $existing = @(Get-ChildItem -LiteralPath $dst -Recurse -Force -File -ErrorAction Stop)
  foreach ($file in $existing) {
    $candidate = $file.FullName.Substring($Tgt.Length + 1).Replace('\','/')
    if ($candidate -cnotin $package) { Stop-Step 20 "existing skill directory holds a file outside the package: $candidate" }
    $sourceHash = Get-FileSha256 (Join-Path $Src ($candidate -replace '/', [IO.Path]::DirectorySeparatorChar))
    if ((Get-FileSha256 $file.FullName) -ne $sourceHash) { Stop-Step 31 "existing installed file differs from the pinned source: $candidate" }
  }
}
foreach ($rel in 'AGENTS.md','CLAUDE.md') {
  $dst = Join-Path $Tgt $rel
  if (Test-Path -LiteralPath $dst) {
    if ((Get-FileSha256 $dst) -ne (Get-FileSha256 (Join-Path $Src $rel))) { Stop-Step 22 "startup file differs: $dst" }
  }
}

# P6 - copy by allow-list only. Existing identical files are skipped, never
# overwritten, so a partial install resumes instead of blocking every retry.
foreach ($rel in $package) {
  $srcPath = Join-Path $Src ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $dst = Join-Path $Tgt ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $parent = Split-Path -Parent $dst
  if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }
  if (Test-Path -LiteralPath $dst) {
    if ((Get-FileSha256 $dst) -eq (Get-FileSha256 $srcPath)) { continue }
    if ($rel -cnotin 'AGENTS.md','CLAUDE.md') { Stop-Step 20 "$dst appeared after P5 and differs from the pinned source" }
    Stop-Step 22 "startup file changed during the copy: $dst"
  }
  Copy-Item -LiteralPath $srcPath -Destination $dst -ErrorAction Stop
}

# P7 - eval material, scoped to the 18 installed skill directories. A directory
# named evals is caught as well as the eval files. Unrelated files elsewhere in
# the target are outside the install and are neither read nor rejected.
foreach ($dir in $skillDirs) {
  $full = Join-Path $Tgt ($dir -replace '/', [IO.Path]::DirectorySeparatorChar)
  $bad = @(Get-ChildItem -LiteralPath $full -Recurse -Force -ErrorAction Stop |
    Where-Object { $_.Name -in 'evals','evals.json','trigger-evals.json' })
  if ($bad.Count) { Stop-Step 30 "eval material present: $($bad[0].FullName)" }
}

# P8 - closure, pins, siblings, forbidden material and the independent aggregate.
$rows = New-Object System.Collections.Generic.List[object]
$missing = @($package | Where-Object {
  -not (Test-Path -LiteralPath (Join-Path $Tgt ($_ -replace '/', [IO.Path]::DirectorySeparatorChar)) -PathType Leaf)
})
if ($missing.Count) { Stop-Step 30 "missing $($missing.Count) of 41: $($missing[0])" }

$extra = @()
foreach ($dir in $skillDirs) {
  $full = Join-Path $Tgt ($dir -replace '/', [IO.Path]::DirectorySeparatorChar)
  foreach ($file in @(Get-ChildItem -LiteralPath $full -Recurse -Force -File -ErrorAction Stop)) {
    $candidate = $file.FullName.Substring($Tgt.Length + 1).Replace('\','/')
    if ($candidate -cnotin $package) { $extra += $candidate }
  }
}
if ($extra.Count) { Stop-Step 30 "file outside the package in an installed skill directory: $($extra[0])" }

$installedSkillFiles = 0
foreach ($dir in $skillDirs) {
  $full = Join-Path $Tgt ($dir -replace '/', [IO.Path]::DirectorySeparatorChar)
  $installedSkillFiles += @(Get-ChildItem -LiteralPath $full -Recurse -Force -File -ErrorAction Stop).Count
}
if ($installedSkillFiles -ne 39) { Stop-Step 30 "installed skill files: $installedSkillFiles, expected 39 (41 paths minus the 2 startup files)" }

foreach ($rel in $package) {
  $dst = Join-Path $Tgt ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $bytes = [IO.File]::ReadAllBytes($dst)
  if ((Get-CrCount $bytes) -ne 0) { Stop-Step 31 "CRLF bytes in $rel - the aggregate and pins are LF-based" }
  $item = Get-Item -LiteralPath $dst -Force
  $rows.Add([pscustomobject]@{
    Path = $rel; Bytes = $item.Length; LF = (Get-LfCount $bytes); SHA256 = (Get-FileSha256 $dst)
  })
}
$ordered = @($rows | Sort-Object -Property Path -CaseSensitive)
# Ordinal sort: culture-aware ordering is not acceptable for the aggregate.
$paths = [string[]]@($ordered | ForEach-Object { $_.Path })
[Array]::Sort($paths, [System.StringComparer]::Ordinal)
$sb = New-Object System.Text.StringBuilder
$byPath = @{}
foreach ($r in $ordered) { $byPath[$r.Path] = $r }
foreach ($p in $paths) {
  $r = $byPath[$p]
  [void]$sb.Append(('{0}' -f $r.Path) + [char]9 + ('{0}' -f $r.Bytes) + [char]9 + ('{0}' -f $r.LF) + [char]9 + $r.SHA256 + [char]10)
}
$serialized = [Text.Encoding]::UTF8.GetBytes($sb.ToString())
$sha = [Security.Cryptography.SHA256]::Create()
try { $aggregate = ([BitConverter]::ToString($sha.ComputeHash($serialized))).Replace('-','').ToLowerInvariant() }
finally { $sha.Dispose() }
if ($rows.Count -ne $AggRows) { Stop-Step 31 "aggregate rows: $($rows.Count), expected $AggRows" }
if ($serialized.Length -ne $AggBytes) { Stop-Step 31 "serialized bytes: $($serialized.Length), expected $AggBytes" }
if ($aggregate -ne $AggSha) { Stop-Step 31 "aggregate $aggregate does not match the published $AggSha" }

$manifest = Get-Content -LiteralPath (Join-Path $Src 'tools/skills-manifest.json') -Raw | ConvertFrom-Json
$manifestPins = 0
foreach ($rel in ($package | Where-Object { $_ -like '.claude/skills/*/SKILL.md' })) {
  $skill = ($rel -split '/')[2]
  $entry = @($manifest.skills | Where-Object { $_.name -eq $skill })
  if ($entry.Count -ne 1) { Stop-Step 31 "no unique manifest entry for $skill" }
  $dst = Join-Path $Tgt ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $text = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($dst)).Replace(([string][char]13 + [char]10), [string][char]10)
  $h = [Security.Cryptography.SHA256]::Create()
  try { $actual = ([BitConverter]::ToString($h.ComputeHash([Text.Encoding]::UTF8.GetBytes($text)))).Replace('-','').ToLowerInvariant() }
  finally { $h.Dispose() }
  if ($actual -ne $entry[0].sha256) { Stop-Step 31 "manifest pin mismatch: $rel" }
  $manifestPins++
}

$sourcePins = 0
foreach ($rel in ($package | Where-Object { $_ -notlike '.claude/skills/*/SKILL.md' })) {
  $dst = Join-Path $Tgt ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $srcFile = Join-Path $Src ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  if ((Get-FileSha256 $dst) -ne (Get-FileSha256 $srcFile)) { Stop-Step 31 "source pin mismatch: $rel" }
  $sourcePins++
}
if ($manifestPins -ne 18 -or $sourcePins -ne 23) { Stop-Step 31 "pin counts $manifestPins/$sourcePins, expected 18/23" }

$siblingMissing = @()
foreach ($rel in ($package | Where-Object { $_ -like '.claude/skills/*' })) {
  $dst = Join-Path $Tgt ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
  $text = Get-Content -LiteralPath $dst -Raw
  foreach ($m in [regex]::Matches($text, '\.\./([a-z0-9-]+)/SKILL\.md')) {
    $sibling = $m.Groups[1].Value
    if (-not (Test-Path -LiteralPath (Join-Path (Join-Path $Tgt '.claude\skills') (Join-Path $sibling 'SKILL.md')) -PathType Leaf)) {
      $siblingMissing += ('{0} links {1}/SKILL.md' -f (($rel -split '/')[2]), $sibling)
    }
  }
}
if ($siblingMissing.Count) { Stop-Step 32 "missing sibling SKILL.md: $($siblingMissing -join '; ')" }

if (-not (Test-Path -LiteralPath $Sh -PathType Leaf)) { Stop-Step 1 "no sh at $Sh" }
$shOut = (& $Sh -c 'echo ok' 2>$null | Out-String).Trim()
if ($LASTEXITCODE -ne 0 -or $shOut -ne 'ok') { Stop-Step 1 "sh did not answer: $Sh" }

Write-Output ('P8: count_check=PASS installed={0} extra=0' -f $rows.Count)
Write-Output ('P8: manifest_pins=PASS {0}/{0}' -f $manifestPins)
Write-Output ('P8: source_pins=PASS {0}/{0}' -f $sourcePins)
Write-Output 'P8: siblings=PASS absent=0'
Write-Output 'P8: forbidden=PASS none'
Write-Output ('P9: rows={0} serialized_bytes={1} aggregate={2} (matches the published value)' -f $rows.Count, $serialized.Length, $aggregate)
if ($RecordPath) {
  $RecordPath = [IO.Path]::GetFullPath($RecordPath)
  if (Test-Path -LiteralPath $RecordPath) {
    Write-Output "P9: install record already present, left unchanged: $RecordPath"
  } else {
    $record = New-Object System.Text.StringBuilder
    $ownerName = (& git -C $Tgt config --local --get aegis.ownerName 2>$null)
    $ownerEmail = (& git -C $Tgt config --local --get aegis.ownerEmail 2>$null)
    $ownerPresent = 'absent - P2 (exit 41) stops before an install; this harness does not enforce P2; values never recorded'
    if ($ownerName -and $ownerEmail) { $ownerPresent = 'present on both keys (values not recorded)' }
    elseif ($ownerName -or $ownerEmail) { $ownerPresent = 'incomplete - one key missing; P2 (exit 41) stops before an install; values never recorded' }
    $branch = (& git -C $Src symbolic-ref -q --short HEAD 2>$null)
    $headState = 'detached HEAD'
    if ($branch) { $headState = 'on branch ' + $branch }
    [void]$record.AppendLine('# Consumer install record - starter package v2')
    [void]$record.AppendLine('')
    [void]$record.AppendLine('- Source: ModernNomad-98/Project-Aegis at commit ' + $head + ' (tree ' + $tree + '), ' + $headState + ', clean.')
    [void]$record.AppendLine('- Installed: ' + (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssK'))
    [void]$record.AppendLine('- Tools: PowerShell ' + $PSVersionTable.PSVersion.ToString() + '; ' + ((& git --version) -join '').Trim() + '; sh ' + $Sh)
    [void]$record.AppendLine('- Owner record: ' + $ownerPresent)
    [void]$record.AppendLine('- Rows: 41; serialized bytes: ' + $serialized.Length + '; aggregate: ' + $aggregate)
    [void]$record.AppendLine('- Result: P5-P8 exit 0. A later mismatch in any row is a stop, not a warning.')
    [void]$record.AppendLine('- Five non-resolving source-repo citations are disclosed in docs/consumer-starter-package.md section 3: docs/skills-catalog.md, docs/paths/design-and-build-ui.md, docs/paths/add-ai-safely.md, docs/paths/release-with-agents.md, docs/acceptance/scenario-a-runbook.md')
    [void]$record.AppendLine('')
    [void]$record.AppendLine('| Path (consumer-relative) | Bytes | LF | SHA-256 |')
    [void]$record.AppendLine('| --- | --- | --- | --- |')
    foreach ($pth in $paths) {
      $r = $byPath[$pth]
      [void]$record.AppendLine(('| {0} | {1} | {2} | {3} |' -f $r.Path, $r.Bytes, $r.LF, $r.SHA256))
    }
    $recordDir = Split-Path -Parent $RecordPath
    if (-not (Test-Path -LiteralPath $recordDir)) { New-Item -ItemType Directory -Path $recordDir | Out-Null }
    [IO.File]::WriteAllText($RecordPath, $record.ToString(), (New-Object Text.UTF8Encoding($false)))
    Write-Output "P9: install record written: $RecordPath"
  }
}
Write-Output 'OK: 41 installed files; closure, pins, siblings, eval and aggregate checks passed'
exit 0
