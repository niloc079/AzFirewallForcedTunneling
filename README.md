# Azure Firewall Forced Tunneling

## IaC
Yes Terraform   =3.70.0 \
No  PowerShell          \
No  Bicep               \
No  Pulumi              

## Working
Azure Firewall Standard \
Restricted Azure Policy and NSG \
Log Analytics x2 for Diagnostic Logging and Policy Analytics \
HUB VNET \
Route Tables and routes to VNG \
Azure Bastion w/ NSG \
ADS Network with DC in Hub

## Other
net-hub-vng-SetDefaultSite.ps1, PowerShell script to set DefaultSite on VNG

## Not Working
Nada

## In Progress
Spoke networks peered to hub and routing through firewall \
Azure Private DNS Zones with Virtual Network Links \
Import of Azure Firewall Workbook with working ARM queries, https://learn.microsoft.com/en-us/azure/firewall/firewall-workbook

## Infracost
Region, Central US \
Total, $393.64
