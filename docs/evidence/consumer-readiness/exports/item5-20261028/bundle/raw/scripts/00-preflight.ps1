$ErrorActionPreference = 'Stop'
$wt = 'C:/src/Project Aegis/_A/remediation/handshake/four-priority-item1'
New-Item -ItemType Directory -Force -Path 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e' | Out-Null
New-Item -ItemType Directory -Force -Path 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e/raw' | Out-Null
New-Item -ItemType Directory -Force -Path 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e/raw/logs' | Out-Null
New-Item -ItemType Directory -Force -Path 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e/raw/scripts' | Out-Null
$ts = Get-Date -Format 'yyyyMMdd-HHmmss'
@(
  ('start_local=' + (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssK')),
  ('start_utc=' + (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')),
  ('ts=' + $ts)
) | Set-Content -LiteralPath 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e/raw/start.stamp' -Encoding utf8NoBOM
'START ' + $ts
'PS ' + $PSVersionTable.PSVersion.ToString()
'OS ' + ((Get-CimInstance Win32_OperatingSystem | ForEach-Object { $_.Caption + ' ' + $_.Version + ' build ' + $_.BuildNumber }) -join '')
'git ' + ((git --version) -join '')
'python ' + ((python --version) -join '')
'python_path ' + ((Get-Command python).Source)
'worktree_status:'
git -C $wt status --porcelain
'HEAD ' + ((git -C $wt rev-parse HEAD) -join '')
'TREE ' + ((git -C $wt rev-parse 'HEAD^{tree}') -join '')
'BRANCH ' + ((git -C $wt branch --show-current) -join '')
'sh_bin ' + (Test-Path 'C:\Program Files\Git\bin\sh.exe')
'sh_usrbin ' + (Test-Path 'C:\Program Files\Git\usr\bin\sh.exe')
& 'C:\Program Files\Git\bin\sh.exe' -c 'echo ok'
'sh_exit=' + $LASTEXITCODE
'lsremote:'
git ls-remote --heads https://github.com/ModernNomad-98/Project-Aegis.git main
