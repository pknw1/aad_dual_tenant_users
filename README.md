```
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

```

A terraform module that provisions users i a secondary Tenant by supplying a source tenant and user


Workspaces
----------

- local       : uses terraform.auto.tfvars; this file is excluded in .gitignore and for local dev



Inputs
------

 - `source_tenant_id` *required* 
 - `source_domain`  *required* 
 - `target_tenant_id` *required* 
 - `target_onmicrosoftcom_domain`  *required* 
 - `source_user_email`  *required* 
 - `target_local_admin` *required* 
 - `target_guest_admin` *required* 
 - `target_local_user`  *required* 
 - `target_guest_user`  *required* 

Process
-------

- validate user against source tenant
- for each of the following `boolean` variables
  - check if a resource already exists
  - if a resource does not exist, create the resource 
  - if a role assignment is required, assign the directory role
  - email the source tenant user with account details

  - this applies to
    - `target_local_*` : an account is created on the target tenant under the target tenant domain  
    - `target_guest_*` : the user is invited using their source tenant AD login - which is used to login to the target tenant


Outputs
-------
- `source_user_email`         : The email of the current processing user
- `source_user_aad_account`   : details pulled from the source tenant for the current user
- `create_guest_admin`        : true/false to create a guest account with Directory Admin
- `guest_admin_username`      : a calculated value based on the user name; a calculated target UPN user_name_contino_io#EXT#@squad0.onmicrosoft.com 
- `create_guest_user`         : true/false to create a guest account
- `guest_user_username`       : a calculated target UPN user_name_contino_io#EXT#@squad0.onmicrosoft.com
- `create_local_admin`        : true/false to create a local account with Directory Admin
- `local_admin_username`      : a calculated username adm-user.name@targetdomain.com
- `create_local_user`         : true/false to create a local account 
- `local_user_username`       : a calculated username user.name@targetdomain.com
- `logline_csc`               : an output that can be used to append to a CSV for logging
- `summary`                   : a summary of the actions and outputs from the rn of the module
- `log-file`                  : one file per run of the module that can be stored as artifacts during deployment


```
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

- the CSV output is one line with 19 elements separaterd by commas


timestamp, module_name, user_email, local_admin_exists, local_admin_requested, target_local_admin, current_action, local_user_exists, local_user_requested, target_local_user, current_action, guest_admin_exists, guest_admin_requested, target_guest_admin, current_action, guest_user_exists, guest_user_requested, target_guest_user, current_action

```

- `timestamp`   is the current runtime
- `module_name` is the current module name
- `user_email`  is the current processing user

- `local` elements are accounts created on the target tenant and will typically use `@onmicrosoft.com` post-fixed accounts; UPNs are at the target domain
- `guest` elements are accounts created by inviting the user from the source tenant and auto-adding; UPNs are identified as `user_name_domain.com#EXT#@squad0.onmicrosoft.com`

