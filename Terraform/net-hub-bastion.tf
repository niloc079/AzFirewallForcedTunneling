# Azure Bastion
#
resource "azurerm_public_ip" "pip-bas" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-bas-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
  public_ip_prefix_id = azurerm_public_ip_prefix.pip-pfx.id
  allocation_method   = "Static"
  sku                 = var.sku
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-bas"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  scale_units         = 2

  ip_configuration {
    name                 = "${var.identifier}${var.environment}${var.application}${var.iteration}-bas"
    subnet_id            = azurerm_subnet.vnet-sub-AzureBastion.id
    public_ip_address_id = azurerm_public_ip.pip-bas.id
  }
}