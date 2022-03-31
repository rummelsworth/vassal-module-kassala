param([Parameter(Mandatory=$true)] $vmodPath)

if ([string]::IsNullOrWhiteSpace($vmodPath))
{
    Write-Error "Path to VMOD file is blank."
    Exit
}

Remove-Item .\vmod -Recurse
New-Item .\vmod -ItemType Directory >$null
[System.IO.Compression.ZipFile]::ExtractToDirectory($vmodPath, ".\vmod")
Write-Host "VMOD file unbuilt."
