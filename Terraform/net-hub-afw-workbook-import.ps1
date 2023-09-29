# Variables
$AzureRmSubscriptionName = "sub-hub"
$RgName = "Workbook-Rg-Name"
$workbookDisplayName = "Azure Firewall"
$workbookSourceId = "Azure Monitor"
$workbookType = "workbook"
$templateUri = "https://raw.githubusercontent.com/dmc-tech/az-workbooks/main/Azure%20Firewall_ARM.json"
$workbookSerializedData = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/Azure/Azure-Network-Security/master/Azure%20Firewall/Workbook%20-%20Azure%20Firewall%20Monitor%20Workbook/Azure%20Firewall_Gallery.json"
 
## Connectivity
# Login first with Connect-AzAccount if not using Cloud Shell
$AzureRmContext = Get-AzSubscription -SubscriptionName $AzureRmSubscriptionName | Set-AzContext -ErrorAction Stop
Select-AzSubscription -Name $AzureRmSubscriptionName -Context $AzureRmContext -Force -ErrorAction Stop
 
## Action
Write-Host "Deploying : $workbookType-$workbookDisplayName in the resource group : $RgName" -ForegroundColor Cyan
New-AzResourceGroupDeployment -Name $(("$workbookType-$workbookDisplayName").replace(' ', '')) -ResourceGroupName $RgName `
-TemplateUri $TemplateUri `
-workbookDisplayName $workbookDisplayName `
-workbookType $workbookType `
-workbookSourceId $workbookSourceId `
-Confirm -ErrorAction Stop
<pre>