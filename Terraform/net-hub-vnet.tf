#
resource "azurerm_virtual_network" "vnet-hub" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_cidr
  #dns_servers         = []
  tags                = var.tags
}

resource "azurerm_subnet" "vnet-sub-GatewaySubnet" {
    name                  = "GatewaySubnet"
    resource_group_name   = azurerm_resource_group.rg.name
    virtual_network_name  = azurerm_virtual_network.vnet-hub.name
    address_prefixes      = var.vnet_cidr_sub1
}

resource "azurerm_subnet" "vnet-sub-AzureFirewallSubnet" {
    name                  = "AzureFirewallSubnet"
    resource_group_name   = azurerm_resource_group.rg.name
    virtual_network_name  = azurerm_virtual_network.vnet-hub.name
    address_prefixes      = var.vnet_cidr_sub2
}

resource "azurerm_subnet" "vnet-sub-AzureFirewallManagementSubnet" {
    name                  = "AzureFirewallManagementSubnet"
    resource_group_name   = azurerm_resource_group.rg.name
    virtual_network_name  = azurerm_virtual_network.vnet-hub.name
    address_prefixes      = var.vnet_cidr_sub3
}

resource "azurerm_subnet" "vnet-sub-AzureBastion" {
    name                  = "AzureBastionSubnet"
    resource_group_name   = azurerm_resource_group.rg.name
    virtual_network_name  = azurerm_virtual_network.vnet-hub.name
    address_prefixes      = var.vnet_cidr_sub4
}

resource "azurerm_subnet" "vnet-sub-ads" {
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-sbn-ads"
    resource_group_name   = azurerm_resource_group.rg.name
    virtual_network_name  = azurerm_virtual_network.vnet-hub.name
    address_prefixes      = var.vnet_cidr_sub5
}
