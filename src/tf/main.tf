#--Service Provider AMA Definition--
data "azurerm_role_definition" "builtin" {
  name = "Contributor"
}
data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "rg-service-provider" {
  name     = "rg-${var.proj_code}-definition-471"
  location = var.location
}


resource "azurerm_managed_application_definition" "ama-def" {
  name                = "managedapplication471"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-service-provider.name
  lock_level          = "ReadOnly"
  package_file_uri    = "https://github.com/Azure/azure-managedapp-samples/raw/master/Managed Application Sample Packages/201-managed-storage-account/managedstorage.zip"
  display_name        = "Testmanagedapplication471"
  description         = "ForTheHybridModel"

  authorization {
    service_principal_id = data.azurerm_client_config.current.object_id
    role_definition_id   = split("/", data.azurerm_role_definition.builtin.id)[length(split("/", data.azurerm_role_definition.builtin.id)) - 1]
  }

  authorization {
    service_principal_id = var.Security_Group_Id
    role_definition_id   = split("/", data.azurerm_role_definition.builtin.id)[length(split("/", data.azurerm_role_definition.builtin.id)) - 1]
  }
}
#--Service Provider AMA--
resource "azurerm_managed_application" "ama01" {
  name                        = "${var.proj_code}-ama-service-provider-471"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg-service-provider.name
  kind                        = "ServiceCatalog"
  managed_resource_group_name = "rg-${var.proj_code}-ama-customer-471"
  application_definition_id   = azurerm_managed_application_definition.ama-def.id

  parameters = {
    location                 = var.location
    storageAccountNamePrefix = "01"
    storageAccountType       = "Standard_LRS"
  }
}

data "azurerm_subscription" "example" {}
