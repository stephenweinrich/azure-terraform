# Create App Service Plans
resource "azurerm_app_service_plan" "app-service-plan-westus" {
  name                = "asp-westus-contoso-${var.environment}"
  location            = "${azurerm_resource_group.resource-group-westus.location}"
  resource_group_name = "${azurerm_resource_group.resource-group-westus.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service_plan" "app-service-plan-eastus" {
  name                = "asp-eastus-contoso-${var.environment}"
  location            = "${azurerm_resource_group.resource-group-eastus.location}"
  resource_group_name = "${azurerm_resource_group.resource-group-eastus.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create App Services
resource "azurerm_app_service" "app-service-westus" {
  name                = "as-westus-contoso-${var.environment}"
  location            = "${azurerm_resource_group.resource-group-westus.location}"
  resource_group_name = "${azurerm_resource_group.resource-group-westus.name}"
  app_service_plan_id = "${azurerm_app_service_plan.app-service-plan-westus.id}"
}

resource "azurerm_app_service" "app-service-eastus" {
  name                = "as-eastus-contoso-${var.environment}"
  location            = "${azurerm_resource_group.resource-group-eastus.location}"
  resource_group_name = "${azurerm_resource_group.resource-group-eastus.name}"
  app_service_plan_id = "${azurerm_app_service_plan.app-service-plan-eastus.id}"
}