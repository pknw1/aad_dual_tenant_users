
provider "azuread" {
  tenant_id = "2fc87606-f7b2-4dc1-81a0-71e4dd53584d"
  alias     = "target"
}


provider "azuread" {
  tenant_id = "538cf6fd-f5d4-4451-8e4a-88c34f2f2619"
  alias     = "source"
}
