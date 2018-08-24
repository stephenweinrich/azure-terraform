# Create Traffic Manager API Profile
resource "azurerm_traffic_manager_profile" "traffic-manager" {
  name                   = "tm-global-contoso-${var.environment}"
  resource_group_name    = "${azurerm_resource_group.resource-group-global.name}"
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = "tm-global-contoso-${var.environment}"
    ttl           = 30
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }
}

# Create Traffic Manager - West End Point
resource "azurerm_traffic_manager_endpoint" "tm-endpoint-west" {
  name                = "Gateway West"
  resource_group_name = "${azurerm_resource_group.resource-group-global.name}"
  profile_name        = "${azurerm_traffic_manager_profile.traffic-manager.name}"
  type                = "externalEndpoints"
  target              = "${azurerm_public_ip.pip_west.fqdn}"
  endpoint_location   = "${azurerm_public_ip.pip_west.location}"
  weight              = 1
}

# Create Traffic Manager - East End Point
resource "azurerm_traffic_manager_endpoint" "tm-endpoint-east" {
  name                = "Gateway East"
  resource_group_name = "${azurerm_resource_group.resource-group-global.name}"
  profile_name        = "${azurerm_traffic_manager_profile.traffic-manager.name}"
  type                = "externalEndpoints"
  target              = "${azurerm_public_ip.pip_east.fqdn}"
  endpoint_location   = "${azurerm_public_ip.pip_east.location}"
  weight              = 1
}
