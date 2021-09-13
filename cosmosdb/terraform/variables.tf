variable "resource_group_name" {
  type    = string
  default = "dotnet_azure_practices"
}

variable "application_id" {
  type    = string
  default = "677f314c-14c1-11ec-82a8-0242ac130003"
}

variable "default_region" {
  type    = string
  default = "centralus"
}

variable "cosmos_account_name" {
  type    = string
  default = "dotnetcosmosdb0242a"
}

variable "cosmos_database_name" {
  type    = string
  default = "pets_db"
}

variable "cosmos_cats_container_name" {
  type    = string
  default = "cats_container"
}

variable "keyvault_name" {
  type    = string
  default = "dotnetcosmoskeyvault"
}