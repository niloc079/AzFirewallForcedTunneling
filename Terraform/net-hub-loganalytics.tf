# Creates Log Anaylytics Workspace
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "law-dig" {
    name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-law-dig"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = var.tags
    sku                 = "PerGB2018"
    retention_in_days   = 30
}

# Creates Log Anaylytics Workspace
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "law-pol" {
    name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-law-pol"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = var.tags
    sku                 = "PerGB2018"
    retention_in_days   = 30
}
