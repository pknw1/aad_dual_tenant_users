
# iterate multiple configurations example

[![asciicast](https://asciinema.org/a/uUM94LwdDMxPNpcTOaMwhpaXu.svg)](https://asciinema.org/a/uUM94LwdDMxPNpcTOaMwhpaXu)

``` tfvars

use_cli_auth         = true
source_tenant_id     = "538cf6fd-f5d4-4451-8e4a-88c34f2f2619"
source_client_id     = ""
source_client_secret = ""
source_domain        = "contino.io"


target_tenant_id             = "2fc87606-f7b2-4dc1-81a0-71e4dd53584d"
target_client_id             = ""
target_client_secret         = ""
target_onmicrosoftcom_domain = "squad0.onmicrosoft.com"


user_configurations = {
  "paul.kelleher@contino.io" = {
    source_user_email  = "paul.kelleher@contino.io"
    target_local_admin = true
    target_local_user  = true
    target_guest_admin = true
    target_guest_user  = false
  }
  "jon.powell@contino.io" = {
    source_user_email  = "jono.powell@contino.io"
    target_local_admin = true
    target_local_user  = false
    target_guest_admin = false
    target_guest_user  = false
  }
}

```

```
module "create_cross_tenant_user" {
  source = "github.com/pknw1/aad_dual_tenant_users?ref=0.0.1"

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
```

<details>
  <summary>Terraform Plan</summary>

```
bash-3.2$ terraform init

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/azuread from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Using previously-installed hashicorp/azuread v2.39.0
- Using previously-installed hashicorp/random v3.5.1
- Using previously-installed hashicorp/local v2.4.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
bash-3.2$ terraform plan -var-file=./terraform.tfvars.development
module.create_cross_tenant_user["jon.powell@contino.io"].data.azuread_user.user_lookup_source_tenant: Reading...
module.create_cross_tenant_user["paul.kelleher@contino.io"].data.azuread_user.user_lookup_source_tenant: Reading...
module.create_cross_tenant_user["jon.powell@contino.io"].data.azuread_user.user_lookup_source_tenant: Read complete after 0s [id=3c47f62a-6cf0-4f21-a2ae-ddb0f08516c0]
module.create_cross_tenant_user["paul.kelleher@contino.io"].data.azuread_user.user_lookup_source_tenant: Read complete after 0s [id=f1b00114-3e9b-45c8-bc18-b549fa041143]
module.create_cross_tenant_user["jon.powell@contino.io"].data.azuread_users.target_tenant_existing_users: Reading...
module.create_cross_tenant_user["paul.kelleher@contino.io"].data.azuread_users.target_tenant_existing_users: Reading...
module.create_cross_tenant_user["jon.powell@contino.io"].data.azuread_user.user_lookup_target_tenant: Reading...
module.create_cross_tenant_user["paul.kelleher@contino.io"].data.azuread_user.user_lookup_target_tenant: Reading...
module.create_cross_tenant_user["jon.powell@contino.io"].data.azuread_users.target_tenant_existing_users: Read complete after 1s [id=users#Yqo8F3gV-RziklJeI7q8OaOlEZQ=]
module.create_cross_tenant_user["paul.kelleher@contino.io"].data.azuread_users.target_tenant_existing_users: Read complete after 1s [id=users#Yqo8F3gV-RziklJeI7q8OaOlEZQ=]
module.create_cross_tenant_user["jon.powell@contino.io"].data.azuread_user.user_lookup_target_tenant: Read complete after 1s [id=68b9d7eb-48fb-43a9-ab98-bd9aeaa0908a]
module.create_cross_tenant_user["paul.kelleher@contino.io"].data.azuread_user.user_lookup_target_tenant: Read complete after 1s [id=79ff1f2c-1133-416d-bed5-d8f83fae55f3]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.create_cross_tenant_user["jon.powell@contino.io"].azuread_directory_role.global_admin will be created
  + resource "azuread_directory_role" "global_admin" {
      + description  = (known after apply)
      + display_name = "Global Administrator"
      + id           = (known after apply)
      + object_id    = (known after apply)
      + template_id  = (known after apply)
    }

  # module.create_cross_tenant_user["jon.powell@contino.io"].local_file.outputs will be created
  + resource "local_file" "outputs" {
      + content              = <<-EOT
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
            
              Source User     jono.powell@contino.io
              Source Tenant   538cf6fd-f5d4-4451-8e4a-88c34f2f2619       
              Target Tenant   2fc87606-f7b2-4dc1-81a0-71e4dd53584d
            
                              exists  requested   create    account name
              account
              local admin   [ true ]    [ true ]  [ false ]   [ adm-jono.powell@squad0.onmicrosoft.com ]
              local user    [ false ]    [ false ]  [ false ]   [ jono.powell@squad0.onmicrosoft.com ]
              guest admin   [ true ]    [ false ]  [ false ]   [ jono.powell_contino.io#EXT#@squad0.onmicrosoft.com ]
              guest suer    [ true ]    [ false ]  [ false ]   [ jono.powell_contino.io#EXT#@squad0.onmicrosoft.com ]
        EOT
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "create_cross_tenant_user-jono.powell@contino.io-summary.log"
      + id                   = (known after apply)
    }

  # module.create_cross_tenant_user["jon.powell@contino.io"].random_password.local_admin will be created
  + resource "random_password" "local_admin" {
      + bcrypt_hash      = (sensitive value)
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + numeric          = true
      + override_special = "!#$%&*()-_=+[]{}<>:?"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

  # module.create_cross_tenant_user["jon.powell@contino.io"].random_password.local_user will be created
  + resource "random_password" "local_user" {
      + bcrypt_hash      = (sensitive value)
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + numeric          = true
      + override_special = "!#$%&*()-_=+[]{}<>:?"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

  # module.create_cross_tenant_user["paul.kelleher@contino.io"].azuread_directory_role.global_admin will be created
  + resource "azuread_directory_role" "global_admin" {
      + description  = (known after apply)
      + display_name = "Global Administrator"
      + id           = (known after apply)
      + object_id    = (known after apply)
      + template_id  = (known after apply)
    }

  # module.create_cross_tenant_user["paul.kelleher@contino.io"].azuread_invitation.local_user[0] will be created
  + resource "azuread_invitation" "local_user" {
      + id                 = (known after apply)
      + redeem_url         = (known after apply)
      + redirect_url       = "https://contino.io"
      + user_display_name  = "Paul Kelleher"
      + user_email_address = "paul.kelleher@contino.io"
      + user_id            = (known after apply)
      + user_type          = "Guest"

      + message {
          + additional_recipients = [
              + "paul.kelleher@contino.io",
            ]
          + body                  = (sensitive value)
        }
    }

  # module.create_cross_tenant_user["paul.kelleher@contino.io"].azuread_user.local_user[0] will be created
  + resource "azuread_user" "local_user" {
      + about_me                       = (known after apply)
      + account_enabled                = true
      + business_phones                = (known after apply)
      + creation_type                  = (known after apply)
      + disable_password_expiration    = false
      + disable_strong_password        = false
      + display_name                   = "Paul Kelleher"
      + external_user_state            = (known after apply)
      + force_password_change          = false
      + id                             = (known after apply)
      + im_addresses                   = (known after apply)
      + mail                           = (known after apply)
      + mail_nickname                  = (known after apply)
      + object_id                      = (known after apply)
      + onpremises_distinguished_name  = (known after apply)
      + onpremises_domain_name         = (known after apply)
      + onpremises_immutable_id        = (known after apply)
      + onpremises_sam_account_name    = (known after apply)
      + onpremises_security_identifier = (known after apply)
      + onpremises_sync_enabled        = (known after apply)
      + onpremises_user_principal_name = (known after apply)
      + password                       = (sensitive value)
      + proxy_addresses                = (known after apply)
      + show_in_address_list           = true
      + user_principal_name            = "adm-paul.kelleher@squad0.onmicrosoft.com"
      + user_type                      = (known after apply)
    }

  # module.create_cross_tenant_user["paul.kelleher@contino.io"].local_file.outputs will be created
  + resource "local_file" "outputs" {
      + content              = <<-EOT
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
            
              Source User     paul.kelleher@contino.io
              Source Tenant   538cf6fd-f5d4-4451-8e4a-88c34f2f2619       
              Target Tenant   2fc87606-f7b2-4dc1-81a0-71e4dd53584d
            
                              exists  requested   create    account name
              account
              local admin   [ true ]    [ true ]  [ false ]   [ adm-paul.kelleher@squad0.onmicrosoft.com ]
              local user    [ false ]    [ true ]  [ true ]   [ paul.kelleher@squad0.onmicrosoft.com ]
              guest admin   [ true ]    [ true ]  [ false ]   [ paul.kelleher_contino.io#EXT#@squad0.onmicrosoft.com ]
              guest suer    [ true ]    [ false ]  [ false ]   [ paul.kelleher_contino.io#EXT#@squad0.onmicrosoft.com ]
        EOT
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "create_cross_tenant_user-paul.kelleher@contino.io-summary.log"
      + id                   = (known after apply)
    }

  # module.create_cross_tenant_user["paul.kelleher@contino.io"].random_password.local_admin will be created
  + resource "random_password" "local_admin" {
      + bcrypt_hash      = (sensitive value)
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + numeric          = true
      + override_special = "!#$%&*()-_=+[]{}<>:?"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

  # module.create_cross_tenant_user["paul.kelleher@contino.io"].random_password.local_user will be created
  + resource "random_password" "local_user" {
      + bcrypt_hash      = (sensitive value)
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + numeric          = true
      + override_special = "!#$%&*()-_=+[]{}<>:?"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

Plan: 10 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
bash-3.2$ exit
exit

```

</details>