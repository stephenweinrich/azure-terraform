variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "environment" {}

# Configure the Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

# Create Resource Groups
resource "azurerm_resource_group" "resource-group-global" {
  name     = "rgp-global-contoso-${var.environment}"
  location = "Central US"
}

resource "azurerm_resource_group" "resource-group-westus" {
  name     = "rgp-westus-contoso-${var.environment}"
  location = "West US"
}

resource "azurerm_resource_group" "resource-group-eastus" {
  name     = "rgp-eastus-contoso-${var.environment}"
  location = "East US"
}