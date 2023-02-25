terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "=0.1.0"
    }

    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.45.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "=3.1.2"
    }
  }
  backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate4376"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

provider "azapi" {
}

provider "azurerm" {
  features {}

  subscription_id   = ""
  tenant_id         = ""
  client_id         = ""
  client_secret     = ""
}

provider "random" {
}