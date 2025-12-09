# ---- Inputs ----
$GraphAppId       = "00000003-0000-0000-c000-000000000000" #would not change
$DisplayNameOfMSI = "name" #name of managed identity
$PermissionName   = "EntitlementManagement.ReadWrite.All" #would not change

#Install Microsoft Graph SDK
Install-Module Microsoft.Graph -Scope CurrentUser -Force

Connect-MgGraph -Scopes "AppRoleAssignment.ReadWrite.All","Application.Read.All"
$MSI     = Get-MgServicePrincipal -Filter "displayName eq '$DisplayNameOfMSI'"

Start-Sleep -Seconds 5

$GraphSp = Get-MgServicePrincipal -Filter "appId eq '$GraphAppId'"
$Role    = $GraphSp.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
$Assignment = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MSI.Id | Where-Object { $_.ResourceId -eq $GraphSp.Id -and $_.AppRoleId -eq $Role.Id }
Remove-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MSI.Id -AppRoleAssignmentId $Assignment.Id
