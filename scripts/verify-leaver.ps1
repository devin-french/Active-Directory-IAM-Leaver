# Read-only validation. Run with ActiveDirectory module and appropriate read permissions.
param([Parameter(Mandatory=$true)][string]$SamAccountName)
Import-Module ActiveDirectory -ErrorAction Stop
$user = Get-ADUser -Identity $SamAccountName -Properties Enabled,Department,DistinguishedName -ErrorAction Stop
$user | Select-Object Name,SamAccountName,Enabled,Department,DistinguishedName | Format-List
Write-Host 'Current group memberships:'
Get-ADPrincipalGroupMembership -Identity $user | Select-Object Name | Sort-Object Name | Format-Table -AutoSize
if ($user.Enabled) { Write-Warning 'Account is still enabled.' } else { Write-Host 'Account is disabled.' }
