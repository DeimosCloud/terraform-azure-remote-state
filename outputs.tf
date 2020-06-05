output "storage_container" {
  value       = azurerm_storage_container.tfstate.*.name
  description = "Name of created storage container"

  depends_on = [azurerm_storage_container.tfstate]
}

output "storage_account_name" {
  value       = azurerm_storage_account.tfstate.*.name
  description = "Name of created storage account"

  depends_on = [azurerm_storage_account.tfstate]
}

output "key" {
  value       = var.key
  description = "The name of the Blob created to retrieve/store Terraform's State file inside the Storage Container"
}
