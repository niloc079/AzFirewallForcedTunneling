#
resource "azurerm_public_ip" "pip-vng" {
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-vng-pip"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    allocation_method     = "Static"
    sku                   = "Standard"
    #zones                = [1,2,3]
    public_ip_prefix_id   = azurerm_public_ip_prefix.pip-pfx.id
}


resource "azurerm_virtual_network_gateway" "vng" {
    depends_on            = [azurerm_public_ip.pip-vng]
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-vng"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name

    type                    = "Vpn"
    vpn_type                = "RouteBased"
    active_active           = false
    enable_bgp              = false
    sku                     = "VpnGw1"

    #Forced Tunnel
    default_local_network_gateway_id = azurerm_local_network_gateway.lng.id

    ip_configuration {
      name                          = azurerm_public_ip.pip-vng.name
      public_ip_address_id          = azurerm_public_ip.pip-vng.id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = azurerm_subnet.vnet-sub-GatewaySubnet.id
    }
}

resource "azurerm_virtual_network_gateway_connection" "onpremise" {
    name                       = "${var.identifier}${var.environment}${var.application}${var.iteration}-lcl"
    location                   = azurerm_resource_group.rg.location
    resource_group_name        = azurerm_resource_group.rg.name
    type                       = "IPsec"
    virtual_network_gateway_id = azurerm_virtual_network_gateway.vng.id
    local_network_gateway_id   = azurerm_local_network_gateway.lng.id
    shared_key                 = var.lng_shared_key
}

resource "azurerm_local_network_gateway" "lng" {
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-lng"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    gateway_address       = var.lng_address
    address_space         = var.lng_cidr
}

