variable "source_tenant_id" {
  type        = string
  description = "The source AAD tenant ID that is considered the master tenant"
  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$", var.source_tenant_id))
    error_message = "Invalid source_tenant_id format. Please provide a valid GUID."
  }
}


variable "source_domain" {
  type        = string
  description = "the FQ domain that is assosciated with the master tenant"

}

variable "target_tenant_id" {
  type        = string
  description = "The target AAD tenant ID that is considered the development tenant"

  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$", var.target_tenant_id))
    error_message = "Invalid target_tenant_id format. Please provide a valid GUID."
  }
}


variable "target_onmicrosoftcom_domain" {
  type        = string
  description = "the onmicrosoft.com domain that is assosciated with the development tenant"

  validation {
    condition     = can(regex(".*onmicrosoft\\.com$", var.target_onmicrosoftcom_domain))
    error_message = "Invalid domain name. The domain should include 'onmicrosoft.com'."
  }
}

variable "source_user_email" {
  type        = string
  description = "The email address of the user (must be active) in the master tenant "

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$", var.source_user_email))
    error_message = "Invalid email address format. Please provide a valid email address."
  }

}
variable "target_local_admin" {
  type        = bool
  description = "If not already existing, create a local user in the development tenant, assign Global Admin role and email the details to the source user"

  default = false
}

variable "target_guest_admin" {
  type        = bool
  description = "If not already existing invite the source user and auto-accept the invite to development tenant, assign Global Admin role and email the details to the source user"

  default = false
}

variable "target_local_user" {
  type        = bool
  description = "If not already existing, create a local user in the development tenant as USER and email the details to the source user"

  default = false
}

variable "target_guest_user" {
  type        = bool
  description = "If not already existing invite the source user and auto-accept the invite to development tenant and email the details to the source user"

  default = false
}