#
resource "azurerm_subnet_network_security_group_association" "vnet-sub-bas-nsg-assoc" {
  subnet_id                 = azurerm_subnet.vnet-sub-AzureBastion.id
  network_security_group_id = azurerm_network_security_group.vnet-sub-bas-nsg.id
}

resource "azurerm_network_security_group" "vnet-sub-bas-nsg" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-sbn-bas-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

    #
    # Inbound
    #

    security_rule {
        name                       = "In-GatewayManager"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "In-AzureLoadBalancer"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "In-HTTPS"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "In-BastionHostComm"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["5701","8080"]
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
    }

    #
    # Outbound
    #

    security_rule {
        name                       = "Out-RDP-SSH"
        priority                   = 1001
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["22","3389"]
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
    }

     security_rule {
        name                       = "Out-AzureCloud"
        priority                   = 1002
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
    }

    security_rule {
        name                       = "Out-BastionHostComm"
        priority                   = 1003
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["5701","8080"]
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
    }

    security_rule {
        name                       = "Out-HTTP"
        priority                   = 1004
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "Internet"
    }
}
