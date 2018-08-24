# Create Vnets
resource "azurerm_virtual_network" "vnet_west" {
  name                = "vnet-westus-contoso-${var.environment}"
  resource_group_name = "${azurerm_resource_group.resource-group-westus.name}"
  location            = "${azurerm_resource_group.resource-group-westus.location}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "vnet_east" {
  name                = "vnet-eastus-contoso-${var.environment}"
  resource_group_name = "${azurerm_resource_group.resource-group-eastus.name}"
  location            = "${azurerm_resource_group.resource-group-eastus.location}"
  address_space       = ["10.0.0.0/16"]
}

# Create Subnets
resource "azurerm_subnet" "subnet_west" {
  name                 = "default"
  resource_group_name  = "${azurerm_resource_group.resource-group-westus.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet_west.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "subnet_east" {
  name                 = "default"
  resource_group_name  = "${azurerm_resource_group.resource-group-eastus.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet_east.name}"
  address_prefix       = "10.0.0.0/24"
}

# Create Dynamic Public IP Addresses
resource "azurerm_public_ip" "pip_west" {
  name                         = "pip-westus-contoso-${var.environment}"
  location                     = "${azurerm_resource_group.resource-group-westus.location}"
  resource_group_name          = "${azurerm_resource_group.resource-group-westus.name}"
  public_ip_address_allocation = "dynamic"
}

resource "azurerm_public_ip" "pip_east" {
  name                         = "pip-eastus-contoso-${var.environment}"
  location                     = "${azurerm_resource_group.resource-group-eastus.location}"
  resource_group_name          = "${azurerm_resource_group.resource-group-eastus.name}"
  public_ip_address_allocation = "dynamic"
}