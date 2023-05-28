
provider "azuread" {
  tenant_id = var.target_tenant_id
  client_id = var.target_client_id
  client_secret = var.target_client_secret
  alias     = "target"
}


provider "azuread" {
  tenant_id = var.source_tenant_id
  client_id = var.source_client_id
  client_secret = var.source_client_secret

  alias     = "source"
}



provider "azuread" {
  tenant_id    = var.target_tenant_id
  use_cli_auth = true
  alias        = "target_development"
}


provider "azuread" {
  tenant_id    = var.source_tenant_id
  use_cli_auth = true
  alias        = "source_development"
}