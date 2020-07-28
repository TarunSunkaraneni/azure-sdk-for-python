# Wrapper Script for ChangeLog Verification
param (
  [String]$ChangeLogLocation,
  [String]$VersionString,
  [string]$PackageName,
  [string]$ServiceName,
  [boolean]$ForRelease = $False
)

. (Join-Path $PSScriptRoot common.ps1)

$validChangeLog = $false
if ($ChangeLogLocation -and $VersionString) 
{
  $validChangeLog = Confirm-ChangeLogEntry -ChangeLogLocation $ChangeLogLocation -VersionString $VersionString -ForRelease $ForRelease
}
else
{
  $PackageProp = Get-PkgProperties -PackageName $PackageName -ServiceName $ServiceName
  $validChangeLog = Confirm-ChangeLogEntry -ChangeLogLocation $PackageProp.pkgChangeLogPath -VersionString $PackageProp.pkgVersion -ForRelease $ForRelease
}

if (!$validChangeLog)
{
  exit 1
}

exit 0