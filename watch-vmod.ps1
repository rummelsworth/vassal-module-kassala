param([string] $vmodPath)

$vmodFolder = Split-Path $vmodPath -Resolve
$vmodFile = Split-Path -Leaf $vmodPath

$watcher = New-Object IO.FileSystemWatcher $vmodFolder , $vmodFile -Property @{
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
