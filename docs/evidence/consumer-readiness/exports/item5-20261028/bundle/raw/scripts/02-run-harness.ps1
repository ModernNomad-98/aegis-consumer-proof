param(
  [Parameter(Mandatory)][string]$Name,
  [Parameter(Mandatory)][string]$Src,
  [Parameter(Mandatory)][string]$Tgt,
  [Parameter(Mandatory)][string]$Harness,
  [string]$RecordPath = '',
  [string]$Sh = 'C:\Program Files\Git\bin\sh.exe'
)
$se = 'C:/src/Project Aegis/_A/remediation/handshake/item1-stage-e'
$out = Join-Path $se ('raw/logs/' + $Name + '.out.log')
$err = Join-Path $se ('raw/logs/' + $Name + '.err.log')
$codePath = Join-Path $se ('raw/logs/' + $Name + '.exit.txt')
$argLine = '-NoProfile -File "' + $Harness + '" -Src "' + $Src + '" -Tgt "' + $Tgt + '" -Sh "' + $Sh + '"'
if ($RecordPath -ne '') { $argLine = $argLine + ' -RecordPath "' + $RecordPath + '"' }
$p = Start-Process -FilePath 'pwsh' -ArgumentList $argLine -Wait -PassThru -NoNewWindow -RedirectStandardOutput $out -RedirectStandardError $err
$p.ExitCode | Set-Content -LiteralPath $codePath -Encoding utf8NoBOM
'RUN ' + $Name + ' exit=' + $p.ExitCode
'--- stdout ---'
Get-Content -LiteralPath $out -Raw
'--- stderr ---'
Get-Content -LiteralPath $err -Raw
'--- exit file ---'
Get-Content -LiteralPath $codePath -Raw
