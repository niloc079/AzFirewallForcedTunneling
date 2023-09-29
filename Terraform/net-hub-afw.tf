#
resource "azurerm_public_ip" "pip-afw" {
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw-pip"
    resource_group_name   = azurerm_resource_group.rg.name
    location              = azurerm_resource_group.rg.location
    allocation_method     = "Static"
    sku                   = var.sku
    #zones                 = [1,2,3]
    tags                  = var.tags
    public_ip_prefix_id   = azurerm_public_ip_prefix.pip-pfx.id
}

resource "azurerm_public_ip" "pip-afw-mgt" {
    name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw-pip-mgt"
    resource_group_name   = azurerm_resource_group.rg.name
    location              = azurerm_resource_group.rg.location
    allocation_method     = "Static"
    sku                   = var.sku
    #zones                 = [1,2,3]
    tags                  = var.tags
    public_ip_prefix_id   = azurerm_public_ip_prefix.pip-pfx.id
}

resource "azurerm_firewall" "afw" {
    depends_on          = [ azurerm_public_ip.pip-afw ]
    name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    tags                = var.tags

    zones               = [1,2,3]
    sku_name            = "AZFW_VNet"
    sku_tier            = var.sku
    threat_intel_mode   = "Alert"
    #dns_servers         = var.dns_servers
    
    firewall_policy_id  = azurerm_firewall_policy.afw-pol.id

  ip_configuration {
    name                    = azurerm_public_ip.pip-afw.name
    subnet_id               = azurerm_subnet.vnet-sub-AzureFirewallSubnet.id
    public_ip_address_id    = azurerm_public_ip.pip-afw.id
  }

  #ForcedTunneling
    #private_ip_ranges   = ["255.255.255.255/32"]  #Always SNAT
    #private_ip_ranges   = ["0.0.0.0/0"]   #Never SNAT
    #private_ip_ranges   = ["IANAPrivateRanges"]    #

  management_ip_configuration {
    name                    = azurerm_public_ip.pip-afw-mgt.name
    subnet_id               = azurerm_subnet.vnet-sub-AzureFirewallManagementSubnet.id
    public_ip_address_id    = azurerm_public_ip.pip-afw-mgt.id
  }
  #ForcedTunneling
}

data "azurerm_monitor_diagnostic_categories" "afw-diag" {
  resource_id = azurerm_firewall.afw.id
}

resource "azurerm_monitor_diagnostic_setting" "afw-diag" {
  name                       = "${var.identifier}${var.environment}${var.application}${var.iteration}-dig"
  target_resource_id         = azurerm_firewall.afw.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law-dig.id

  #dynamic "log" {
  dynamic "enabled_log" {
    #for_each = data.azurerm_monitor_diagnostic_categories.afw-diag.logs
    for_each = data.azurerm_monitor_diagnostic_categories.afw-diag.log_category_types
    content {
      #category = log.value
      category = enabled_log.value
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.afw-diag.metrics
    content {
      category = metric.value
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}