terraform {
  required_providers {
        azurerm = {
      source = "hashicorp/azurerm"
      version = "3.35.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "ef5467a5-6f78-4d24-8cd0-7e150d47ef02"
    tenant_id = "8b266952-26e7-437d-9f33-06603ce13f26"
    client_id = "10c6dfe3-2255-4cac-8139-3978fc21f8ef"
    client_secret = ".~m8Q~d1kLfdwPh6G1NG7vftThYAV53LaWHbmdgm"
  features {}
}
