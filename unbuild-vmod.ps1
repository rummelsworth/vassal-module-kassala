param([Parameter(Mandatory=$true)] $vmod)

if ([string]::IsNullOrWhiteSpace($vmod))
{
    throw "Path to VMOD file is blank."
}

Remove-Item .\vmod -Recurse
New-Item .\vmod -ItemType Directory >$null
[System.IO.Compression.ZipFile]::ExtractToDirectory($vmod, ".\vmod")
