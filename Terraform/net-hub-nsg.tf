resource "azurerm_network_security_group" "vnet-sub-ads-nsg" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-sbn-ads-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
 
    #
    # Inbound
    #

  security_rule {
    name                       = "In-HTTPS"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "In-RDP-SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = ["22","3389"]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    #
    # Outbound
    #

    security_rule {
    name                       = "Out-HTTPS"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Out-RDP-SSH"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = ["22","3389"]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
 
resource "azurerm_subnet_network_security_group_association" "vnet-sub-ads-nsg-assoc" {
  subnet_id                 = azurerm_subnet.vnet-sub-ads.id
  network_security_group_id = azurerm_network_security_group.vnet-sub-ads-nsg.id
}
