output "source_user_email" { value = var.source_user_email }
output "source_user_aad_account" { value = data.azuread_user.user_lookup_source_tenant }
output "create_guest_admin" { value = var.target_guest_admin }
output "guest_admin_username" { value = local.target_guest_admin }

output "create_guest_user" { value = var.target_guest_user }
output "guest_user_username" { value = local.target_guest_user }

output "create_local_admin" { value = var.target_local_admin }
output "local_admin_username" { value = local.target_local_admin }

output "create_local_user" { value = var.target_local_user }
output "local_user_username" { value = local.target_local_user }

output "logline_csc" {
  value = local.logline
}




resource "local_file" "outputs" {
  content  = local.summary
  filename = "${local.module}-${var.source_user_email}-summary.log"
}

