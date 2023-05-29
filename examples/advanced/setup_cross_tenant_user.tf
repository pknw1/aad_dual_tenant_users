module "create_cross_tenant_user" {
  source = "github.com/pknw1/aad_dual_tenant_users?ref=latest"

  providers = {
    azuread.source = azuread.source,
    azuread.target = azuread.target
  }

  for_each = var.user_configurations

  source_tenant_id             = var.source_tenant_id
  source_domain                = var.source_domain
  target_tenant_id             = var.target_tenant_id
  target_onmicrosoftcom_domain = var.target_onmicrosoftcom_domain
  source_user_email            = each.value.source_user_email
  target_local_admin           = each.value.target_local_admin
  target_guest_admin           = each.value.target_guest_admin
  target_local_user            = each.value.target_local_user
  target_guest_user            = each.value.target_guest_user

}
