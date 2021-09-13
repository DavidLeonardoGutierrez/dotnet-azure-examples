data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "name" {
  name                        = var.keyvault_name
  location                    = var.default_region
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy = [
    {
      application_id          = var.application_id
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = data.azurerm_client_config.current.object_id
      key_permissions         = ["get"]
      secret_permissions      = ["get", "list", "set", "delete"]
      storage_permissions     = ["get"]
      certificate_permissions = ["get"]
  }]
}
