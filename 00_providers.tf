terraform {
  required_providers {
    azuread = {
      source                = "hashicorp/azuread"
      version               = "2.39.0"
      configuration_aliases = [azuread.source, azuread.target]
    }
  }
}
