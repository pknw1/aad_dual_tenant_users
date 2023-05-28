resource "azuread_directory_role" "global_admin" {
  display_name = "Global Administrator" #or any other directory role

  provider = azuread.target

}

resource "azuread_directory_role_assignment" "admin" {

  count = local.create_local_admin == true ? 1 : 0

  role_id             = azuread_directory_role.global_admin.template_id
  principal_object_id = data.azuread_user.user_lookup_target_tenant.object_id

  provider = azuread.target

   lifecycle {
    create_before_destroy = true
  }

}


