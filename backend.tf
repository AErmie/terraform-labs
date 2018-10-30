terraform {
  backend "azurerm" {
  storage_account_name = "terraformstatesalab6"
  container_name       = "terraformstate"
  key                  = "citadellabs.terraform.tfstate"
  access_key           = "XKqpCeG50pxE8ucF9pKBu5kKYAk5af7pHX6DZSc/inJ63ujz049PkMRIhxrrbXH0PpV+Oq8Ho7uOYBlWP+QcRg=="
  }
}