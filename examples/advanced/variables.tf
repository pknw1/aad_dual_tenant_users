variable "use_cli_auth" {
  type = bool
  default = false
}

variable "source_tenant_id" {
  type = string
}

variable "source_client_id" {
  type    = string
  default = ""
}

variable "source_client_secret" {
  type    = string
  default = ""
}


variable "source_domain" {
  type = string
}




variable "target_tenant_id" {
  type = string
}


variable "target_client_id" {
  type    = string
  default = ""
}

variable "target_client_secret" {
  type    = string
  default = ""
}

variable "target_onmicrosoftcom_domain" {
  type = string
}

variable "user_configurations" {
  type    = map(any)
  default = {}
}