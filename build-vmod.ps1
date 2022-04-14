param([switch] $noWatch)

$tag = git tag --points-at HEAD
$sha = git rev-parse --short HEAD
$timestamp = (Get-Date).ToString("yyyyMMddHHmmssfff")
$vmodPath = ".\Kassala_$tag+${sha}_$timestamp.vmod"
Remove-Item -ErrorAction Ignore "$vmodPath"
[IO.Compression.ZipFile]::CreateFromDirectory(".\vmod", $vmodPath)
Write-Host "VMOD file built: $vmodPath"

if ($noWatch)
{
    exit
}

& ".\watch-vmod.ps1" $vmodPath
