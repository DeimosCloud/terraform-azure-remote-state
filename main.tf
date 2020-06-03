terraform {
  required_version = ">= 0.12"

  required_providers {
    azurerm  = "~> 2.0.0"
    local    = ">= 1.2"
    null     = ">= 2.1"
    template = ">= 2.1"
    random   = ">= 2.1"
  }
}

resource "random_id" "this" {
  byte_length = "10"
}

##### Locals
locals {
  bucket_name          = var.bucket_name != "" ? var.bucket_name : "terraform-state-${random_id.this.hex}"
  resource_group_name  = "${var.name_prefix}-${random_id.this.hex}"
  storage_account_name = "${var.name_prefix}-${random_id.this.hex}"
  container_name       = "${var.name_prefix}-${random_id.this.hex}"
}


# Create a new resource group for storing state if resource_group_name is not passed as variable
resource "azurerm_resource_group" "tfstate" {
  count    = var.resource_group_name == "" ? 1 : 0
  name     = local.resource_group_name
  location = var.location
}

# Create a storage account only if it has not been passed as variable
resource "azurerm_storage_account" "tfstate" {
  count                    = var.storage_account_name == "" ? 1 : 0
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name == "" ? azurerm_resource_group.tfstate.*.name : var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = local.container_name
  storage_account_name  = var.storage_account_name == "" ? azurerm_storage_account.tfstate.*.name : var.storage_account_name
  container_access_type = "private"
}

################# AUTOMATING REMOTE STATE LOCKING
data "template_file" "remote_state" {
  template = "${file("${path.module}/templates/remote_state.tpl")}"
  vars = {
    resource_group_name  = var.resource_group_name == "" ? azurerm_resource_group.tfstate.*.name : var.resource_group_name
    storage_account_name = var.storage_account_name == "" ? azurerm_storage_account.tfstate.*.name : var.storage_account_name
    container_name       = var.container_name == "" ? azurerm_storage_container.tfstate.*.name : var.container_name
    key                  = var.key
  }
}

resource "null_resource" "remote_state_locks" {
  depends_on = [aws_s3_bucket.remote_state]
  provisioner "local-exec" {
    command = "sleep 20;cat > ${var.backend_output_path}<<EOL\n${data.template_file.remote_state.rendered}"
  }
}
