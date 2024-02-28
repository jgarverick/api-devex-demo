terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    azcli = {
      source = "azure/azapi"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=1.0"
    }
  }
  required_version = ">=1.0"
}

provider "azurerm" {
  features {

  }
}
