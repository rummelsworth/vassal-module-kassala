param([switch] $NoWatch)

$tag = git tag --points-at HEAD
$sha = git rev-parse --short HEAD
$timestamp = (Get-Date).ToString("yyyyMMddHHmmssfff")
$vmodName = "Kassala_$tag+${sha}_$timestamp.vmod"
$vmodPath = ".\$vmodName"
Remove-Item -ErrorAction Ignore "$vmodPath"
[IO.Compression.ZipFile]::CreateFromDirectory(".\vmod", $vmodPath)
Write-Host "VMOD file built: $vmodPath"

if ($NoWatch)
{
    Exit
}

$watcher = New-Object IO.FileSystemWatcher ".", $vmodName -Property @{
    NotifyFilter = [IO.NotifyFilters]::LastWrite
}

$watcherEventSourceId = [guid]::NewGuid()
$watcherEventJob = Register-ObjectEvent $watcher -SourceIdentifier $watcherEventSourceId -EventName Changed -Action {
    Write-Host "VMOD file change detected."
    & ".\unbuild-vmod.ps1" $Event.SourceEventArgs.FullPath
}

$watcher.EnableRaisingEvents = $true

Write-Host "Press Ctrl+C to stop watching VMOD build output." -ForegroundColor ([ConsoleColor]::Yellow)

try
{
    Wait-Event -SourceIdentifier $watcherEventSourceId
}
finally
{
    $null = while ([Console]::KeyAvailable) { [Console]::ReadKey($true) }
    $watcherEventJob | Remove-Job -Force
}
