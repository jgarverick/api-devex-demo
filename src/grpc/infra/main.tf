resource "azurerm_linux_web_app" "name" {
  location            = var.location
  name                = "app-devex-demo-grpc"
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.name.id
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = data.azurerm_application_insights.ai.instrumentation_key
    "APPINSIGHTS_CONNECTION_STRING"  = data.azurerm_application_insights.ai.connection_string
  }
  site_config {
    always_on             = true
    api_management_api_id = azurerm_api_management_api.name.id
  }
  # auth_settings {
  #     enabled = true
  #   active_directory {
  #     allowed_audiences = ["https://app-devex-demo-grpc.azurewebsites.net"]
  #     client_id = "141150cc-4830-4e0d-ad3b-0d5dc766b044"
  #   }
  # }
}

resource "azurerm_service_plan" "name" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "app-devex-demo-grpc-service-plan"
  os_type             = "Linux"
  sku_name            = "S1"
}

data "azurerm_api_management" "name" {
  resource_group_name = var.resource_group_name
  name                = "apim-devex-demo"
}

data "azurerm_application_insights" "ai" {
  name                = "ai-api-devex-demo"
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_api" "name" {
  resource_group_name = var.resource_group_name
  api_management_name = data.azurerm_api_management.name.name
  name                = "grpc-api"
  revision            = "v1"
  display_name        = "Sample gRPC API"
  protocols           = ["https"]
  api_type            = "http"
  path                = "grpc"

}
