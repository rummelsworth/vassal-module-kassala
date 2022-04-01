param([string] $Path)

if ([string]::IsNullOrWhiteSpace($Path))
{
    Write-Error "Path to VMOD file is blank."
    Exit
}

Remove-Item .\vmod -Recurse
New-Item .\vmod -ItemType Directory >$null
[IO.Compression.ZipFile]::ExtractToDirectory($Path, ".\vmod")
Write-Host "VMOD file unbuilt."
