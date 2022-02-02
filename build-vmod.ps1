$vmod = ".\Kassala.vmod"
Remove-Item -ErrorAction Ignore "$vmod"
[System.IO.Compression.ZipFile]::CreateFromDirectory(".\vmod", $vmod)
