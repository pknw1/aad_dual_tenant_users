
## Obtain a list of all users
data "azuread_users" "target_tenant_existing_users" {
  return_all = true
  
  provider   = azuread.target

}

data "azuread_user" "user_lookup_source_tenant" {
  mail = var.source_user_email

  provider = azuread.source
}



data "azuread_user" "user_lookup_target_tenant" {
  user_principal_name = local.target_guest_user

  provider = azuread.target
}


