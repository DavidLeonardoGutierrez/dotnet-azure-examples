

#-----------------------------------------------------Terraform run things
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.73.0"
    }
  }
}
 
# For some reason terraform needs these empty features.
provider "azurerm" {
  features {}
}

#-----------------------------------------------------Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.default_region
}

#-----------------------------------------------------CosmosDb
resource "azurerm_cosmosdb_account" "db" {
  name                = "${cosmos_account_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  tags = { 
      "layer"        = "database"
  }
  
  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
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