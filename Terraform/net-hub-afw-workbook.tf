data "http" "AzureFirewallWorkbookGallery" {
  url = "https://raw.githubusercontent.com/Azure/Azure-Network-Security/master/Azure%20Firewall/Workbook%20-%20Azure%20Firewall%20Monitor%20Workbook/Azure%20Firewall_Gallery.json"

  request_headers = {
    Accept = "application/json"
  }
}

data "http" "AzureFirewallWorkbookGalleryARM" {
  url = "https://raw.githubusercontent.com/dmc-tech/az-workbooks/main/Azure%20Firewall_ARM.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "azurerm_application_insights_workbook" "AzureFirewallWorkbook" {
  name                = "1f7d3cd7-248a-4eea-90c2-568c9f56c504"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  display_name        = "Azure Firewall Workbook"
  data_json = jsonencode({
    "version" = "Notebook/1.0",
    "items" = [
      {
        "type" = 1,
        "content" = {
          "json" = "Test2022"
        },
        "name" = "text - 0"
      }
    ],
    "isLocked" = false,
    "fallbackResourceIds" = [
      "Azure Monitor"
    ]
  })

  tags = {
    ENV = "Test"
  }
}