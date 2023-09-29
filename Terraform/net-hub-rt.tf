# Route Table GatewaySubnet
resource "azurerm_route_table" "vnet-GatewaySubnet-rt" {
  name                          = "${var.identifier}${var.environment}${var.application}${var.iteration}-sbn-GatewaySubnet-rt"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  disable_bgp_route_propagation = false

    route {
      name                    = azurerm_virtual_network.vnet-hub.name
      #address_prefix          = var.vnet_cidr
      address_prefix          = flatten(var.vnet_cidr)[0]
      next_hop_type           = "VirtualAppliance"
      next_hop_in_ip_address  = azurerm_firewall.afw.ip_configuration[0].private_ip_address
    }
}

resource "azurerm_subnet_route_table_association" "vnet-GatewaySubnet-rt-assoc" {
  subnet_id      = azurerm_subnet.vnet-sub-GatewaySubnet.id
  route_table_id = azurerm_route_table.vnet-GatewaySubnet-rt.id
}

#Route Table Azure Firewall
resource "azurerm_route_table" "vnet-sbn-afw-rt" {
  name                          = "${var.identifier}${var.environment}${var.application}${var.iteration}-sbn-afw-rt"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  disable_bgp_route_propagation = false

route {
  name           = "VirtualNetworkGateway"
  #address_prefix = flatten(var.defaultroutecidr)[0]
  address_prefix = "0.0.0.0/0"
  next_hop_type  = "VirtualNetworkGateway"
  }
}

resource "azurerm_subnet_route_table_association" "vnet-sbn-afw-rt-assoc" {
  subnet_id      = azurerm_subnet.vnet-sub-AzureFirewallSubnet.id
  route_table_id = azurerm_route_table.vnet-sbn-afw-rt.id
}

# Route Table ADS
resource "azurerm_route_table" "vnet-sbn-ads-rt" {
  name                          = "${var.identifier}${var.environment}${var.application}${var.iteration}-sbn-ads-rt"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  disable_bgp_route_propagation = true

  route {
    name                    = "AzureFirewall"
    address_prefix          = "0.0.0.0/0"
    next_hop_type           = "VirtualAppliance"
    next_hop_in_ip_address  = azurerm_firewall.afw.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "vnet-sbn-ads-rt-assoc" {
  subnet_id      = azurerm_subnet.vnet-sub-ads.id
  route_table_id = azurerm_route_table.vnet-sbn-ads-rt.id
}
