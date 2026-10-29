$ErrorActionPreference = 'Stop'
$se = 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e'
$envj = Get-Content -LiteralPath (Join-Path $se 'raw/fixtures/env.json') -Raw | ConvertFrom-Json
$base = $envj.dest
$srcClone = $envj.src
$harness = Join-Path $se 'raw/fixtures/install-starter.ps1'
$sh = 'C:\Program Files\Git\bin\sh.exe'
$fixtures = 'C:\temp\aegis-item1-fixtures'
New-Item -ItemType Directory -Force -Path $fixtures | Out-Null
$unrelated = @('README.md','.gitignore','notes/unrelated.txt','.claude/settings.json','.claude/skills/my-own-skill/SKILL.md','src/app.py')

function Hash-File([string]$p) { if (Test-Path -LiteralPath $p -PathType Leaf) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.ToLowerInvariant() } else { $null } }
function Get-Unrelated([string]$root) {
  $rows = foreach ($u in $unrelated) { [pscustomobject]@{ path=$u; bytes=$(if (Test-Path -LiteralPath (Join-Path $root ($u -replace '/','\')) -PathType Leaf) { (Get-Item -LiteralPath (Join-Path $root ($u -replace '/','\'))).Length } else { $null }); sha256=(Hash-File (Join-Path $root ($u -replace '/','\'))) } }
  return $rows
}
function Get-TreeMap([string]$root) {
  $map = @{}
  foreach ($f in Get-ChildItem -LiteralPath $root -Recurse -Force -File -ErrorAction SilentlyContinue) {
    if ($f.FullName -replace [regex]::Escape($root), '' -match '\\\.git\\') { continue }
    $rel = $f.FullName.Substring($root.Length + 1).Replace('\','/')
    $map[$rel] = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
  }
  return $map
}
function Invoke-Case([string]$name, [string]$srcPath, [string]$tgtPath, [bool]$record) {
  $out = Join-Path $se ('raw/logs/case-' + $name + '.out.log')
  $err = Join-Path $se ('raw/logs/case-' + $name + '.err.log')
  $argLine = '-NoProfile -File "' + $harness + '" -Src "' + $srcPath + '" -Tgt "' + $tgtPath + '" -Sh "' + $sh + '"'
  if ($record) { $argLine = $argLine + ' -RecordPath "' + (Join-Path $tgtPath 'docs/consumer-install-record.md') + '"' }
  $before = Get-TreeMap $tgtPath
  $unBefore = Get-Unrelated $tgtPath
  $recordBefore = Hash-File (Join-Path $tgtPath 'docs/consumer-install-record.md')
  $p = Start-Process -FilePath 'pwsh' -ArgumentList $argLine -Wait -PassThru -NoNewWindow -RedirectStandardOutput $out -RedirectStandardError $err
  $code = $p.ExitCode
  $after = Get-TreeMap $tgtPath
  $unAfter = Get-Unrelated $tgtPath
  $added = @($after.Keys | Where-Object { -not $before.ContainsKey($_) })
  $changed = @($after.Keys | Where-Object { $before.ContainsKey($_) -and $before[$_] -ne $after[$_] })
  $unrelatedUnchanged = $true
  for ($i = 0; $i -lt $unBefore.Count; $i++) { if ($unBefore[$i].bytes -ne $unAfter[$i].bytes -or $unBefore[$i].sha256 -ne $unAfter[$i].sha256) { $unrelatedUnchanged = $false } }
  $result = [pscustomobject]@{
    case = $name
    source = $srcPath
    target = $tgtPath
    exit_code = $code
    stderr = (Get-Content -LiteralPath $err -Raw)
    stdout = (Get-Content -LiteralPath $out -Raw)
    files_before = $before.Count
    files_after = $after.Count
    added = $added
    changed = $changed
    unrelated_unchanged = $unrelatedUnchanged
    record_before_sha256 = $recordBefore
    record_after_sha256 = (Hash-File (Join-Path $tgtPath 'docs/consumer-install-record.md'))
  }
  $result | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $se ('raw/fixtures/case-' + $name + '.json')) -Encoding utf8NoBOM
  'CASE ' + $name + ' exit=' + $code + ' added=' + $added.Count + ' changed=' + $changed.Count + ' unrelated_unchanged=' + $unrelatedUnchanged
  '  stderr: ' + (($result.stderr -split "\r?\n" | Where-Object { $_ -ne '' } | Select-Object -First 1) -join '')
  '  stdout: ' + (($result.stdout -split "\r?\n" | Where-Object { $_ -ne '' } | Select-Object -First 1) -join '')
}

function New-DestCopy([string]$name) {
  $d = Join-Path $fixtures ('tgt-' + $name)
  if (Test-Path -LiteralPath $d) { Remove-Item -LiteralPath $d -Recurse -Force }
  Copy-Item -LiteralPath $base -Destination $d -Recurse -Force
  return $d
}
function New-FreshTarget([string]$name) {
  $d = Join-Path $fixtures ('tgt-' + $name)
  if (Test-Path -LiteralPath $d) { Remove-Item -LiteralPath $d -Recurse -Force }
  New-Item -ItemType Directory -Force -Path (Join-Path $d 'notes'), (Join-Path $d 'src'), (Join-Path $d '.claude/skills/my-own-skill') | Out-Null
  Copy-Item -LiteralPath (Join-Path $base 'README.md') -Destination (Join-Path $d 'README.md')
  Copy-Item -LiteralPath (Join-Path $base '.gitignore') -Destination (Join-Path $d '.gitignore')
  Copy-Item -LiteralPath (Join-Path $base 'notes/unrelated.txt') -Destination (Join-Path $d 'notes/unrelated.txt')
  Copy-Item -LiteralPath (Join-Path $base '.claude/settings.json') -Destination (Join-Path $d '.claude/settings.json')
  Copy-Item -LiteralPath (Join-Path $base '.claude/skills/my-own-skill/SKILL.md') -Destination (Join-Path $d '.claude/skills/my-own-skill/SKILL.md')
  Copy-Item -LiteralPath (Join-Path $base 'src/app.py') -Destination (Join-Path $d 'src/app.py')
  return $d
}
function New-SourceWorktree([string]$name) {
  $w = Join-Path $fixtures ('src-' + $name)
  if (Test-Path -LiteralPath $w) { git -C $srcClone worktree remove --force $w 2>$null; Remove-Item -LiteralPath $w -Recurse -Force -ErrorAction SilentlyContinue }
  git -C $srcClone worktree add --detach $w ffb040c7a363648856475280646bbd142dfabe4e 2>&1 | Out-Null
  if ($LASTEXITCODE -ne 0) { throw ('worktree add failed for ' + $name) }
  return $w
}

# A1 - changed destination byte
$a1 = New-DestCopy 'dest-changed-byte'
Add-Content -LiteralPath (Join-Path $a1 '.claude/skills/code-reviewer/references/severity-rubric.md') -Value 'X' -NoNewline
Invoke-Case 'dest-changed-byte' $srcClone $a1 $false

# A2 - evaluation-answer contamination in a destination skill directory
$a2 = New-DestCopy 'dest-eval'
New-Item -ItemType Directory -Force -Path (Join-Path $a2 '.claude/skills/test-plan-designer/evals') | Out-Null
Set-Content -LiteralPath (Join-Path $a2 '.claude/skills/test-plan-designer/evals/evals.json') -Value '{"answer":"contaminated"}' -NoNewline -Encoding utf8NoBOM
Invoke-Case 'dest-eval' $srcClone $a2 $false

# A3 - conflicting startup bytes
$a3 = New-DestCopy 'dest-agents-conflict'
Add-Content -LiteralPath (Join-Path $a3 'AGENTS.md') -Value 'X' -NoNewline
Invoke-Case 'dest-agents-conflict' $srcClone $a3 $false

# A4 - foreign non-package file in an installed skill directory
$a4 = New-DestCopy 'dest-foreign-file'
Set-Content -LiteralPath (Join-Path $a4 '.claude/skills/plan-of-record-author/references/extra.md') -Value 'foreign' -NoNewline -Encoding utf8NoBOM
Invoke-Case 'dest-foreign-file' $srcClone $a4 $false

# B1 - changed source byte hidden from git status by assume-unchanged
$b1src = New-SourceWorktree 'changed-byte'
git -C $b1src update-index --assume-unchanged '.claude/skills/code-reviewer/references/severity-rubric.md'
Add-Content -LiteralPath (Join-Path $b1src '.claude/skills/code-reviewer/references/severity-rubric.md') -Value 'X' -NoNewline
$b1tgt = New-FreshTarget 'src-changed-byte'
Invoke-Case 'src-changed-byte' $b1src $b1tgt $false

# B2 - missing required reference hidden from git status
$b2src = New-SourceWorktree 'missing-ref'
git -C $b2src update-index --assume-unchanged '.claude/skills/scoped-approval-register/references/register-format.md'
Remove-Item -LiteralPath (Join-Path $b2src '.claude/skills/scoped-approval-register/references/register-format.md') -Force
$b2tgt = New-FreshTarget 'src-missing-ref'
Invoke-Case 'src-missing-ref' $b2src $b2tgt $false

# B3 - malformed manifest (invalid JSON)
$b3src = New-SourceWorktree 'manifest-json'
git -C $b3src update-index --assume-unchanged 'tools/skills-manifest.json'
Set-Content -LiteralPath (Join-Path $b3src 'tools/skills-manifest.json') -Value '{ this is not valid json' -NoNewline -Encoding utf8NoBOM
$b3tgt = New-FreshTarget 'src-manifest-json'
Invoke-Case 'src-manifest-json' $b3src $b3tgt $false

# B4 - malformed manifest (valid JSON, wrong shape)
$b4src = New-SourceWorktree 'manifest-shape'
git -C $b4src update-index --assume-unchanged 'tools/skills-manifest.json'
Set-Content -LiteralPath (Join-Path $b4src 'tools/skills-manifest.json') -Value '{"skills":"not-an-array"}' -NoNewline -Encoding utf8NoBOM
$b4tgt = New-FreshTarget 'src-manifest-shape'
Invoke-Case 'src-manifest-shape' $b4src $b4tgt $false

# Cleanup worktrees
foreach ($w in @($b1src,$b2src,$b3src,$b4src)) { git -C $srcClone worktree remove --force $w 2>$null | Out-Null }
git -C $srcClone worktree prune
