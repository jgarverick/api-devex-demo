
data "azurerm_api_management" "example" {
  name                = "apim-devex-demo"
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_api" "name" {
  resource_group_name = var.resource_group_name
  api_management_name = data.azurerm_api_management.example.name
  name                = "echo-api"
  revision            = "v1"
  display_name        = "Echo API"
  protocols           = ["https"]
  api_type            = "http"

  import {
    content_format = "openapi"
    content_value  = file("../src/echo-api.json")
  }
}

resource "azurerm_api_management_api_policy" "name" {
  api_name            = azurerm_api_management_api.name.name
  api_management_name = data.azurerm_api_management.example.name
  resource_group_name = var.resource_group_name
  xml_content         = file("../src/api-policy.cshtml")
}
