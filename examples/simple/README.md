
# a single call 

[![asciicast](https://asciinema.org/a/aQsDiqsoHjurWDtdWJvs4Rphl.svg)](https://asciinema.org/a/aQsDiqsoHjurWDtdWJvs4Rphl)


```
module "create_cross_tenant_user" {
  source = "github.com/pknw1/aad_dual_tenant_users?ref=0.0.1"

  providers = {
    azuread.source = azuread.source,
    azuread.target = azuread.target
  }

  source_tenant_id             = "538cf6fd-f5d4-4451-8e4a-XXXXXXXXXXXX"
  source_domain                = "contino.io"
  target_tenant_id             = "2fc87606-f7b2-4dc1-81a0-XXXXXXXXXXXX"
  target_onmicrosoftcom_domain = "squad0.onmicrosoft.com"
  source_user_email            = "paul.kelleher@contino.io"
  target_local_admin           = true
  target_guest_admin           = false
  target_local_user            = false
  target_guest_user            = true

}


```

<details>
  <summary>Terraform Plan</summary>

```
bash-3.2$ terraform plan
module.create_cross_tenant_user.data.azuread_user.user_lookup_target_tenant: Reading...
module.create_cross_tenant_user.data.azuread_users.target_tenant_existing_users: Reading...
module.create_cross_tenant_user.data.azuread_user.user_lookup_source_tenant: Reading...
module.create_cross_tenant_user.data.azuread_users.target_tenant_existing_users: Read complete after 1s [id=users#Yqo8F3gV-RziklJeI7q8OaOlEZQ=]
module.create_cross_tenant_user.data.azuread_user.user_lookup_target_tenant: Read complete after 1s [id=79ff1f2c-1133-416d-bed5-d8f83fae55f3]
module.create_cross_tenant_user.data.azuread_user.user_lookup_source_tenant: Read complete after 1s [id=f1b00114-3e9b-45c8-bc18-b549fa041143]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.create_cross_tenant_user.azuread_directory_role.global_admin will be created
  + resource "azuread_directory_role" "global_admin" {
      + description  = (known after apply)
      + display_name = "Global Administrator"
      + id           = (known after apply)
      + object_id    = (known after apply)
      + template_id  = (known after apply)
    }

  # module.create_cross_tenant_user.local_file.outputs will be created
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
              local user    [ false ]    [ false ]  [ false ]   [ paul.kelleher@squad0.onmicrosoft.com ]
              guest admin   [ true ]    [ false ]  [ false ]   [ paul.kelleher_contino.io#EXT#@squad0.onmicrosoft.com ]
              guest suer    [ true ]    [ true ]  [ false ]   [ paul.kelleher_contino.io#EXT#@squad0.onmicrosoft.com ]
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

  # module.create_cross_tenant_user.random_password.local_admin will be created
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

  # module.create_cross_tenant_user.random_password.local_user will be created
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

Plan: 4 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
bash-3.2$ exit

```

</details>

