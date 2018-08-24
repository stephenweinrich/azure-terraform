# Create Application Gateways
resource "azurerm_application_gateway" "application-gateway-west" {
  name                = "ag-westus-contoso-${var.environment}"
  resource_group_name = "${azurerm_resource_group.resource-group-westus.name}"
  location            = "${azurerm_resource_group.resource-group-westus.location}"

  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  waf_configuration {
    enabled          = "true"
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }

  gateway_ip_configuration {
    name      = "subnet"
    subnet_id = "${azurerm_virtual_network.vnet_west.id}/subnets/${azurerm_subnet.subnet_west.name}"
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = "${azurerm_public_ip.pip_west.id}"
  }

  backend_address_pool {
    name        = "AppService"
    "fqdn_list" = ["${azurerm_app_service.app-service-westus.name}.azurewebsites.net"]
  }

  http_listener {
    name                           = "http"
    frontend_ip_configuration_name = "frontend"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  probe {
    name                = "probe"
    protocol            = "http"
    path                = "/"
    host                = "${azurerm_app_service.app-service-westus.name}.azurewebsites.net"
    interval            = "30"
    timeout             = "30"
    unhealthy_threshold = "3"
  }

  backend_http_settings {
    name                  = "http"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
    probe_name            = "probe"
  }

  request_routing_rule {
    name                       = "http"
    rule_type                  = "Basic"
    http_listener_name         = "http"
    backend_address_pool_name  = "AppService"
    backend_http_settings_name = "http"
  }
}

resource "azurerm_application_gateway" "application-gateway-east" {
  name                = "ag-eastus-contoso-${var.environment}"
  resource_group_name = "${azurerm_resource_group.resource-group-eastus.name}"
  location            = "${azurerm_resource_group.resource-group-eastus.location}"

  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  waf_configuration {
    enabled          = "true"
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }

  gateway_ip_configuration {
    name      = "subnet"
    subnet_id = "${azurerm_virtual_network.vnet_east.id}/subnets/${azurerm_subnet.subnet_east.name}"
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = "${azurerm_public_ip.pip_east.id}"
  }

  backend_address_pool {
    name        = "AppService"
    "fqdn_list" = ["${azurerm_app_service.app-service-eastus.name}.azurewebsites.net"]
  }

  http_listener {
    name                           = "http"
    frontend_ip_configuration_name = "frontend"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  probe {
    name                = "probe"
    protocol            = "http"
    path                = "/"
    host                = "${azurerm_app_service.app-service-eastus.name}.azurewebsites.net"
    interval            = "30"
    timeout             = "30"
    unhealthy_threshold = "3"
  }

  backend_http_settings {
    name                  = "http"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
    probe_name            = "probe"
  }

  request_routing_rule {
    name                       = "http"
    rule_type                  = "Basic"
    http_listener_name         = "http"
    backend_address_pool_name  = "AppService"
    backend_http_settings_name = "http"
  }
}