$tag = git tag --points-at HEAD
$sha = git rev-parse --short HEAD
$timestamp = (Get-Date).ToString("yyyyMMddHHmmssfff")
$vmod = ".\Kassala_$tag+${sha}_$timestamp.vmod"
Remove-Item -ErrorAction Ignore "$vmod"
[System.IO.Compression.ZipFile]::CreateFromDirectory(".\vmod", $vmod)
