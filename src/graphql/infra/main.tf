data "azurerm_api_management" "example" {
  name                = "apim-devex-demo"
  resource_group_name = var.resource_group_name
}

data "azurerm_application_insights" "ai" {
  name                = "ai-api-devex-demo"
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_api" "name" {
  name                = "graph-api"
  resource_group_name = var.resource_group_name
  api_management_name = data.azurerm_api_management.example.name
  revision            = "v1"
  display_name        = "Sample GraphQL API"
  protocols           = ["https"]
  api_type            = "graphql"

  import {
    content_format = "swagger-json"
    content_value  = file("../src/docs/swagger.json")
  }
  path                  = "graphql"
  subscription_required = true
}

resource "azurerm_api_management_backend" "name" {
  api_management_name = data.azurerm_api_management.example.name
  resource_group_name = var.resource_group_name
  url                 = "https://${azurerm_linux_function_app.example.name}.azurewebsites.net/graphql"
  protocol            = "http"
  name                = azurerm_api_management_api.name.name
  description         = azurerm_api_management_api.name.display_name

}

resource "azurerm_linux_function_app" "example" {
  name                       = "fct-devex-demo-graphql"
  resource_group_name        = var.resource_group_name
  location                   = data.azurerm_api_management.example.location
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  service_plan_id = azurerm_service_plan.example.id
  site_config {
    always_on                              = true
    api_management_api_id                  = azurerm_api_management_api.name.id
    application_insights_connection_string = data.azurerm_application_insights.ai.connection_string
    application_stack {
      node_version = "18"

    }
  }
}

resource "azurerm_service_plan" "example" {
  name                = "app-service-plan"
  resource_group_name = var.resource_group_name
  location            = data.azurerm_api_management.example.location
  os_type             = "Linux"
  sku_name            = "S1"

}

resource "azurerm_storage_account" "example" {
  name                     = "stgfxgraphql001"
  resource_group_name      = var.resource_group_name
  location                 = data.azurerm_api_management.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
