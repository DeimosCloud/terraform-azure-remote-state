output "storage_container" {
  value       = azurerm_storage_container.tfstate.*.name
  description = "Name of created storage container"

  depends_on = [azurerm_storage_container.tfstate]
}

output "resource_group" {
  value       = azurerm_resource_group.tfstate.*.name
  description = "Name of created resource group"

  depends_on = [azurerm_resource_group.tfstate]
}

output "storage_account" {
  value       = azurerm_storage_account.tfstate.*.name
  description = "Name of created storage account"

  depends_on = [azurerm_storage_account.tfstate]
}

output "key" {
  value       = var.key
  description = "The name of the Blob created to retrieve/store Terraform's State file inside the Storage Container"
}
