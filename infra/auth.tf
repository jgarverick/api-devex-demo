resource "azuread_application" "name" {
  display_name            = "apim-devex-demo-auth"
  sign_in_audience        = "AzureADMyOrg"
  group_membership_claims = ["All"]
}

resource "azuread_application_password" "name" {
  application_id = azuread_application.name.application_id
}

resource "azuread_application_redirect_uris" "name" {
  application_id = azuread_application.name.application_id
  redirect_uris = ["https://${azurerm_api_management.example.name}.developer.azure-api.net/signin",
    "https://${azurerm_api_management.example.name}.developer.azure-api.net",
    "https://authorization-manager.consent.azure-apim.net/redirect/apim/${azurerm_api_management.example.name}",
  "https://${azurerm_api_management.example.name}.azure-api.net/.auth/login/aad/callback"]
  type = "SPA"
}
