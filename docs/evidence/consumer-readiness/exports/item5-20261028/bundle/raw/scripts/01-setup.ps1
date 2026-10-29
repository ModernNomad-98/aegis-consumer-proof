$ErrorActionPreference = 'Stop'
$se = 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e'
$stamp = Get-Content -LiteralPath (Join-Path $se 'raw/start.stamp') | ForEach-Object { if ($_ -match '^ts=(.*)$') { $Matches[1] } }
$dest = 'C:\temp\aegis-item1-consumer-' + $stamp
$src  = 'C:\temp\aegis-src-' + $stamp
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Push-Location $dest
try {
  if (-not (Test-Path -LiteralPath (Join-Path $dest '.git'))) { git init | Out-Null }
  git config --local aegis.ownerName 'Fixture Owner (synthetic, non-authorizing)'
  git config --local aegis.ownerEmail 'owner@example.invalid'
  git config --local user.name 'DeepSeek V4 Flash'
  git config --local user.email 'deepseek-v4-flash@users.noreply.github.com'

  New-Item -ItemType Directory -Force -Path (Join-Path $dest 'notes'), (Join-Path $dest 'src'), (Join-Path $dest '.claude/skills/my-own-skill') | Out-Null
  Set-Content -LiteralPath (Join-Path $dest 'README.md') -Value '# Fixture consumer product - unrelated to the starter package.' -NoNewline -Encoding utf8NoBOM
  Set-Content -LiteralPath (Join-Path $dest '.gitignore') -Value 'build/' -NoNewline -Encoding utf8NoBOM
  Set-Content -LiteralPath (Join-Path $dest 'notes/unrelated.txt') -Value 'This file must survive the install unchanged.' -NoNewline -Encoding utf8NoBOM
  Set-Content -LiteralPath (Join-Path $dest '.claude/settings.json') -Value '{"permissions":{"allow":[]}}' -NoNewline -Encoding utf8NoBOM
  Set-Content -LiteralPath (Join-Path $dest '.claude/skills/my-own-skill/SKILL.md') -Value '# my own unrelated skill' -NoNewline -Encoding utf8NoBOM
  Set-Content -LiteralPath (Join-Path $dest 'src/app.py') -Value 'print(1)' -NoNewline -Encoding utf8NoBOM

  $unrelated = @('README.md','.gitignore','notes/unrelated.txt','.claude/settings.json','.claude/skills/my-own-skill/SKILL.md','src/app.py')
  $rows = foreach ($rel in $unrelated) {
    $p = Join-Path $dest ($rel -replace '/', '\')
    [pscustomobject]@{ path=$rel; bytes=(Get-Item -LiteralPath $p).Length; sha256=((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.ToLowerInvariant()) }
  }
  $rows | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $se 'raw/fixtures/unrelated-before.json') -Encoding utf8NoBOM

  'DEST ' + $dest
  'SOURCE ' + $src

  $landmarks = @(
    [bool]((Test-Path -LiteralPath 'README.md') -and (Select-String -LiteralPath 'README.md' -Pattern '^# Project Aegis' -Quiet -ErrorAction SilentlyContinue)),
    (Test-Path -LiteralPath 'docs/skills-catalog.md'),
    (Test-Path -LiteralPath 'scripts/validate-skills.py'),
    (Test-Path -LiteralPath 'artifacts/audits/skill-contract-audit-baseline.json'))
  $count = @($landmarks | Where-Object { $_ }).Count
  'P1: count=' + $count + ' classification=' + $(if ($count -eq 0) { 'Role B consumer' } else { 'AMBIGUOUS/LIBRARY - STOP' })

  $ownerName  = (git config --local --get aegis.ownerName) 2>$null
  $ownerEmail = (git config --local --get aegis.ownerEmail) 2>$null
  if ([string]::IsNullOrWhiteSpace($ownerName) -or [string]::IsNullOrWhiteSpace($ownerEmail)) { throw 'P2 exit 41: owner record missing' }
  $authorLine    = (git var GIT_AUTHOR_IDENT) 2>$null
  $committerLine = (git var GIT_COMMITTER_IDENT) 2>$null
  'P2: owner record present on both --local keys (values synthetic)'
  'P2: author=' + $authorLine
  'P2: committer=' + $committerLine
  $ownerMatch = ($authorLine -like ('*' + $ownerEmail + '*')) -or ($committerLine -like ('*' + $ownerEmail + '*'))
  if ($ownerMatch) { throw 'P2 exit 42: commit identity matches owner record' }
  'P2: commit identity differs from the owner record; continue'

  if (Test-Path -LiteralPath $src) { Remove-Item -LiteralPath $src -Recurse -Force }
  git clone --no-checkout -c core.autocrlf=false -c core.eol=lf https://github.com/ModernNomad-98/Project-Aegis.git $src
  if ($LASTEXITCODE -ne 0) { throw 'git clone failed' }
  git -C $src checkout --detach ffb040c7a363648856475280646bbd142dfabe4e
  if ($LASTEXITCODE -ne 0) { throw 'git checkout failed' }
  $head = ((& git -C $src rev-parse HEAD) -join '').Trim()
  $tree = ((& git -C $src rev-parse 'HEAD^{tree}') -join '').Trim()
  if ($head -ne 'ffb040c7a363648856475280646bbd142dfabe4e') { throw ('P3 exit 31: HEAD ' + $head) }
  if ($tree -ne '88a5aee4ad928a49c2fb945032585843ec652da7') { throw ('P3 exit 31: tree ' + $tree) }
  if (@(git -C $src status --porcelain).Count) { throw 'P3 exit 31: source clone not clean' }
  $badEol = @(git -C $src ls-files --eol -- AGENTS.md CLAUDE.md .claude/skills | Where-Object { $_ -match 'w/crlf' })
  if ($badEol.Count) { throw ('P3 exit 31: CRLF checkout: ' + $badEol[0]) }
  'P3: HEAD=' + $head
  'P3: TREE=' + $tree
  'P3: status clean; w/crlf matches=0'

  [pscustomobject]@{ dest=$dest; src=$src; stamp=$stamp; head=$head; tree=$tree } | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $se 'raw/fixtures/env.json') -Encoding utf8NoBOM
} finally { Pop-Location }
