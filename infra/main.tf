data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_api_management" "example" {
  name                = "apim-devex-demo"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "My Company"
  publisher_email     = "company@example.com"

  tenant_access {
    enabled = true
  }

  sku_name = "Developer_1"
  identity {
    type = "SystemAssigned"
  }

}

resource "azurerm_api_management_identity_provider_aad" "name" {
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.example.name
  client_id           = azuread_application.name.application_id
  client_secret       = azuread_application_password.name.value
  allowed_tenants     = [data.azurerm_client_config.current.tenant_id]
}



resource "azurerm_key_vault" "example" {
  name                        = "akv-api-devex-demo"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_api_management.example.identity[0].principal_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Import",
      "Delete",
      "Backup",
      "Restore",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Backup",
      "Restore",
    ]
  }
}

resource "azurerm_resource_group_template_deployment" "apic" {
  resource_group_name = azurerm_resource_group.example.name
  template_content    = file("./apic.json")
  name                = "deploy-apic-demo"
  deployment_mode     = "Incremental"
}

resource "azurerm_application_insights" "ai" {
  name                = "ai-api-devex-demo"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
}
