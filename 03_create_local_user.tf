


resource "random_password" "local_user" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


resource "azuread_user" "local_user" {

  count = local.create_local_user == true ? 1 : 0

  user_principal_name = local.target_local_admin
  display_name        = data.azuread_user.user_lookup_source_tenant.display_name
  password            = random_password.local_user.result

  provider = azuread.target

}


resource "azuread_invitation" "local_user" {

  count = local.create_local_user == true ? 1 : 0

  user_display_name  = data.azuread_user.user_lookup_source_tenant.display_name
  user_email_address = var.source_user_email
  redirect_url       = "https://contino.io"
  user_type          = "Guest"
  message {
    additional_recipients = ["paul.kelleher@contino.io"]
    body                  = <<EOF

    A new Squad 0 local account has been created for you 
    Please go to     https://portal.azure.com/#@squad0.onmicrosoft.com asap and login using 

    username:   ${local.target_local_user}
    password:   ${random_password.local_user.result}

    and change your pasword immediately

    EOF
  }

   lifecycle {
    create_before_destroy = true
  }

  provider = azuread.target
}



