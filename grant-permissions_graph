# ---- Inputs ----
$GraphAppId = "00000003-0000-0000-c000-000000000000" #would not change
$DisplayNameOfMSI="name" #name of managed identity
$PermissionName = "EntitlementManagement.ReadWrite.All" #would not change

Connect-MgGraph -Scopes "Application.Read.All","AppRoleAssignment.ReadWrite.All"
$MSI = Get-MgServicePrincipal -Filter "displayName eq '$DisplayNameOfMSI'"

Start-Sleep -Seconds 5

$GraphServicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MSI.Id -principalId $MSI.Id -resourceId $GraphServicePrincipal.Id -appRoleId $AppRole.Id 
