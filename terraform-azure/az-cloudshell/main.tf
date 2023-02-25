terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.45.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate4376"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}

  subscription_id   = ""
  tenant_id         = ""
  client_id         = ""
  client_secret     = ""
}



resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}