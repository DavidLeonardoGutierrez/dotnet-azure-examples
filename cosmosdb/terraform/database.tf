#-----------------------------------------------------CosmosDb
resource "azurerm_cosmosdb_account" "db_account" {
  name                = var.cosmos_account_name
  location            = var.default_region
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  tags = {
    "layer" = "database"
  }

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.default_region
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "pets_database" {
  name                = var.cosmos_database_name
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.db_account.name
}

resource "azurerm_cosmosdb_sql_container" "pets_container" {
  name                  = var.cosmos_cats_container_name
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.db_account.name
  database_name         = azurerm_cosmosdb_sql_database.pets_database.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "Consistent"
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
