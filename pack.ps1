<#
    .SYNOPSIS
    Creates a sign key file from secret
    .DESCRIPTION
    Creates a sign key file from secret
    .PARAMETER file
    Name of the key file to generate
    .PARAMETER key
    base64 encoded key file
    .NOTES
    Written by Ralf Beckers
#>

if (${{ matrix.build_configuration }} -ne 'Release') {
  Write-Host "Not a Release build"
  exit 0
}

$currentDirectory = Get-Location

$nuspecs = Get-ChildItem -Path $currentDirectory -Include *.nuspec -Recurse
ForEach ($nuspec in $nuspecs ) 
{
	$folder = [IO.Path]::GetDirectoryName($nuspec)
    $name = [IO.Path]::::GetFileName($nuspec)

	Write-Host "Pack $name ..."
	
	push-location $folder
	nuget pack $name -properties Configuration=Release
    pop-location
}

