module "create_cross_tenant_user" {
  source = "../../"

  providers = {
    azuread.source = azuread.source,
    azuread.target = azuread.target
  }

  source_tenant_id             = "538cf6fd-f5d4-4451-8e4a-88c34f2f2619"
  source_domain                = "contino.io"
  target_tenant_id             = "2fc87606-f7b2-4dc1-81a0-71e4dd53584d"
  target_onmicrosoftcom_domain = "squad0.onmicrosoft.com"
  source_user_email            = "paul.kelleher@contino.io"
  target_local_admin           = true
  target_guest_admin           = false
  target_local_user            = false
  target_guest_user            = true

}
