# Create virtual machine
#
resource "azurerm_windows_virtual_machine" "iaas-vm-ads" {
  name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-vm-ads"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  tags                  = var.tags
  network_interface_ids = [azurerm_network_interface.iaas-vm-nic-ads.id]
  admin_username        = "azureuser"
  admin_password        = random_password.random_password.result
  computer_name         = "${var.identifier}${var.environment}${var.application}${var.iteration}vmads"
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "${var.identifier}${var.environment}${var.application}${var.iteration}-vm-ads-dsk-os"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

# Create public IPs
#resource "azurerm_public_ip" "iaas-ads-pip" {
#  name                = "${var.environment}${var.application}${var.iteration}-vm2-pip"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  allocation_method   = "Static"
#  sku                 = var.sku
#  public_ip_prefix_id = azurerm_public_ip_prefix.pip-pfx.id
#}

# Create network interface
resource "azurerm_network_interface" "iaas-vm-nic-ads" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-vm-ads-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.identifier}${var.environment}${var.application}${var.iteration}-vm-ads-nic"
    subnet_id                     = azurerm_subnet.vnet-sub-ads.id
    private_ip_address_allocation = "Dynamic"
  }
}
