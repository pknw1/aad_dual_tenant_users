locals {
  target_local_admin = "adm-${replace(var.source_user_email, var.source_domain, var.target_onmicrosoftcom_domain)}"
  target_local_user  = replace(var.source_user_email, var.source_domain, var.target_onmicrosoftcom_domain)
  target_guest_user  = join("#", [replace(var.source_user_email, "@", "_"), "EXT#@${var.target_onmicrosoftcom_domain}"])
  target_guest_admin = local.target_guest_user

  create_local_admin = var.target_local_admin == true ? !contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_local_admin) : false
  create_local_user  = var.target_local_user == true ? !contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_local_user) : false

  create_guest_user  = var.target_guest_user == true ? !contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_guest_user) : false
  create_guest_admin = var.target_guest_admin == true ? !contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_guest_admin) : false

  create_guest = local.create_guest_admin == true ? true : local.create_guest_user

  module = basename(abspath(path.module))

  logline = "${timestamp()}, ${local.module}, ${var.source_user_email}, ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_local_admin)}, ${var.target_local_admin},  ${local.create_local_admin}, ${local.target_local_admin}, ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_local_user)}, ${var.target_local_user},  ${local.create_local_user}, ${local.target_local_user}, ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_guest_admin)}, ${var.target_guest_admin},  ${local.create_guest_admin}, ${local.target_guest_admin}, ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_guest_user)}, ${var.target_guest_user},  ${local.create_guest_user}, ${local.target_guest_user}"

  summary = <<EOT
                  _   _                                                               _   _          
                 _   _                                                               _   _          
  ___ ___  _ __ | |_(_)_ __   ___     __ _ _____   _ _ __ ___   _ __  _ __ __ _  ___| |_(_) ___ ___ 
 / __/ _ \| '_ \| __| | '_ \ / _ \   / _` |_  / | | | '__/ _ \ | '_ \| '__/ _` |/ __| __| |/ __/ _ \
| (_| (_) | | | | |_| | | | | (_) | | (_| |/ /| |_| | | |  __/ | |_) | | | (_| | (__| |_| | (_|  __/
 \___\___/|_| |_|\__|_|_| |_|\___/   \__,_/___|\__,_|_|  \___| | .__/|_|  \__,_|\___|\__|_|\___\___|
                                                               |_|                                  

    _        _    ____     ____                     _____                      _     ____                   
   / \      / \  |  _ \   / ___|_ __ ___  ___ ___  |_   _|__ _ __   __ _ _ __ | |_  / ___| _   _ _ __   ___ 
  / _ \    / _ \ | | | | | |   | '__/ _ \/ __/ __|   | |/ _ \ '_ \ / _` | '_ \| __| \___ \| | | | '_ \ / __|
 / ___ \  / ___ \| |_| | | |___| | | (_) \__ \__ \   | |  __/ | | | (_| | | | | |_   ___) | |_| | | | | (__ 
/_/   \_\/_/   \_\____/   \____|_|  \___/|___/___/   |_|\___|_| |_|\__,_|_| |_|\__| |____/ \__, |_| |_|\___|
                                                                                           |___/      
                 _   _       _            __                              _  ___  
  ___ ___  _ __ | |_(_) ___ | |__   __ _  \ \   ___  __ _ _   _  __ _  __| |/ _ \ 
 / __/ _ \| '_ \| __| |/ _ \| '_ \ / _` |  \ \ / __|/ _` | | | |/ _` |/ _` | | | |
| (_| (_) | | | | |_| | (_) | | | | (_| |  / / \__ \ (_| | |_| | (_| | (_| | |_| |
 \___\___/|_| |_|\__|_|\___/|_| |_|\__, | /_/  |___/\__, |\__,_|\__,_|\__,_|\___/ 
                                      |_|              |_|                       



  AAD Cross Tenant User Control
  -----------------------------

  Source User     ${var.source_user_email}
  Source Tenant   ${var.source_tenant_id}       
  Target Tenant   ${var.target_tenant_id}

                  exists  requested   create    account name
  account
  local admin   [ ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_local_admin)} ]    [ ${var.target_local_admin} ]  [ ${local.create_local_admin} ]   [ ${local.target_local_admin} ]
  local user    [ ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_local_user)} ]    [ ${var.target_local_user} ]  [ ${local.create_local_user} ]   [ ${local.target_local_user} ]
  guest admin   [ ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_guest_admin)} ]    [ ${var.target_guest_admin} ]  [ ${local.create_guest_admin} ]   [ ${local.target_guest_admin} ]
  guest suer    [ ${contains(data.azuread_users.target_tenant_existing_users.user_principal_names, local.target_guest_user)} ]    [ ${var.target_guest_user} ]  [ ${local.create_guest_user} ]   [ ${local.target_guest_user} ]
EOT
}
