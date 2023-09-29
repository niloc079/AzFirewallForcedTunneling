#
resource "azurerm_public_ip_prefix" "pip-pfx" {
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-pip-pfx"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    tags                  = var.tags
    prefix_length         = 30
}
