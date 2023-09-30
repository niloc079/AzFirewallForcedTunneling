#
#Env Variables
identifier                     = ""             #Org name
environment                    = "hub"          #Hub, Prd, Stg, Dev, Tst, Idp
application                    = "net"          #net, app, ads
iteration                      = ""             #Numeric
location                       = "centralus"    #Azure Location
application_owner              = "Mark Brendanawicz"
deployment_source              = "terraform"
#
#Tags
tags =  {
identifier                     = ""             #Org name
environment                    = "hub"          #Hub, Prd, Stg, Dev, Tst, Idp
application                    = "net"          #net, app, ads
location                       = "centralus"    #Azure Location
iteration                      = ""             #Numeric
application_owner              = "Mark Brendanawicz"
deployment_source              = "terraform"
        }
#VNG
lng_shared_key          = "?VPN Shared Key?"
lng_address             = "?VPN IP?"
lng_cidr                = ["10.100.0.0/24"]     #OnPrem
defaultroutecidr        = "0.0.0.0/0"
#AFW
vnet_cidr               = ["10.200.0.0/16"]     #VNET CIDR
vnet_cidr_sub1          = ["10.200.0.0/27"]     #GatewaySubnet
vnet_cidr_sub2          = ["10.200.32.0/26"]    #AzureFirewallSubnet
vnet_cidr_sub3          = ["10.200.32.64/26"]   #AzureFirewallManagementSubnet
vnet_cidr_sub4          = ["10.200.32.128/26"]  #AzureBastion
vnet_cidr_sub5          = ["10.200.32.192/26"]  #ADS
dns_servers             = ["8.8.8.8","8.8.4.4"]
sku                     = "Standard"
