param([switch] $watch)

$buildHelp = {
    pandoc .\rules.md -o .\help\rules.html -s --citeproc --bibliography .\The_Complete_Book_of_Wargames.bibtex
    Write-Host "Help build complete."
}

& $buildHelp

if ($watch)
{
    $watcher = New-Object IO.FileSystemWatcher "." , "rules.md" -Property @{
        NotifyFilter = [IO.NotifyFilters]::LastWrite
    }
    
    $watcherEventSourceId = [guid]::NewGuid()
    $watcherEventJob = Register-ObjectEvent $watcher -SourceIdentifier $watcherEventSourceId -EventName Changed -MessageData $buildHelp -Action {
        Write-Host "Help source file change detected."
        & $Event.MessageData
    }
    
    $watcher.EnableRaisingEvents = $true
    
    Write-Host "Press Ctrl+C to stop watching help source file." -ForegroundColor ([ConsoleColor]::Yellow)
    
    try
    {
        Wait-Event -SourceIdentifier $watcherEventSourceId
    }
    finally
    {
        $null = while ([Console]::KeyAvailable) { [Console]::ReadKey($true) }
        $watcherEventJob | Remove-Job -Force
    }
}
