$vmodName = "Kassala.vmod"
$vmodPath = ".\$vmodName"
$vmodZipPath = "$vmodPath.zip"

Remove-Item -ErrorAction Ignore "$vmodPath"
Compress-Archive .\vmod\* "$vmodZipPath"
Rename-Item "$vmodZipPath" "$vmodName"
