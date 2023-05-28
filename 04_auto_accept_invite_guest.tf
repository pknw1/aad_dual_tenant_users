

resource "azuread_invitation" "squad0" {

  count = local.create_guest == true ? 1 : 0

  user_display_name  = data.azuread_user.user_lookup_source_tenant.display_name
  user_email_address = var.source_user_email
  redirect_url       = "https://portal.azure.com/#@squad0.onmicrosoft.com"
  user_type          = "Guest"
  message {
    additional_recipients = ["paul.kelleher@contino.io"]
    body                  = <<EOF
    This is an automated message - please contact Azure practice via slack wioth any questions
    Any Contino user that has a resource provisioned in the squad0 tenant requires your account 
    has guest access from your normal continohq login
    
    Only users currently assigned a role within squad0 tenant will remain enabled in the new tenant 
    - no subscription = no access
    
    EOF
  }

   lifecycle {
    create_before_destroy = true
  }

  provider = azuread.target
}



