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

$watcher = New-Object System.IO.FileSystemWatcher ".", $vmodName -Property @{
    NotifyFilter = [IO.NotifyFilters]::LastWrite
}

$watcherEventJob = Register-ObjectEvent $watcher -EventName Changed -Action {
    Write-Host "VMOD file change detected."
    & ".\unbuild-vmod.ps1" $Event.SourceEventArgs.FullPath
}

$watcher.EnableRaisingEvents = $true

$sessionControlCAsInput = [Console]::TreatControlCAsInput
[Console]::TreatControlCAsInput = $true
Write-Host "Press Ctrl+C to stop watching VMOD build output." -ForegroundColor ([ConsoleColor]::Yellow)

while ($true)
{
    if ([Console]::KeyAvailable)
    {
        $keyInfo = [Console]::ReadKey($true)
        if ($keyInfo.Modifiers -eq [ConsoleModifiers]::Control -and $keyInfo.Key -eq [ConsoleKey]::C)
        {
            [Console]::TreatControlCAsInput = $sessionControlCAsInput
            $watcherEventJob | Remove-Job -Force
            Exit
        }
    }
    else
    {
        Start-Sleep 0.2
    }
}
