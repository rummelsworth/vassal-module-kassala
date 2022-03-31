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

Register-ObjectEvent $watcher -EventName Changed -Action {
    Write-Host "VMOD file change detected."
    & ".\unbuild-vmod.ps1" $Event.SourceEventArgs.FullPath
} >$null

$watcher.EnableRaisingEvents = $true

Write-Host "Press Ctrl+C to stop watching VMOD build output." -ForegroundColor ([ConsoleColor]::Yellow)

while ($true)
{
    if ([Console]::KeyAvailable)
    {
        $keyInfo = [Console]::ReadKey($true)
        if ($keyInfo.Modifiers -eq [ConsoleModifiers]::Control -and $keyInfo.Key -eq [ConsoleKey]::C)
        {
            Exit
        }
    }
    else
    {
        Start-Sleep 0.5
    }
}
