terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    azcli = {
      source = "azure/azapi"
    }
  }
  required_version = ">=1.0"
}

provider "azurerm" {
  features {

  }
}
