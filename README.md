# Remote State Locking Azure
A terraform module to automate creation and configuration of backend using azure blob


## Basic Usage

```hcl
resource "azurerm_resource_group" "tfstate" {
  name     = var.resource_group_name
  location = var.location
}

module "remote_state_locking" {
  source   = "git::https://gitlab.com/deimosdev/tooling/terraform-modules/terraform-remote-state-azure"

  resource_group_name = azurerm_resource_group.tfstate.name
}
```


```hcl
resource "azurerm_resource_group" "tfstate" {
  name     = var.resource_group_name
  location = var.location
}

# You can pass storage account
resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "remote_state_locking" {
  source   = "git::https://gitlab.com/deimosdev/tooling/terraform-modules/terraform-remote-state-azure"

  resource_group_name  = azurerm_resource_group.tfstate.name
  storage_account_name = azurerm_storage_account.tfstate.name
}
```

This creates a `backend.tf` file in the specified `backend_output_path` (default: project directory). Apply the configured backend by running `terraform init` again

## Contributing

Report issues/questions/feature requests on in the issues section.

Full contributing guidelines are covered [here](CONTRIBUTING.md).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |
| null | n/a |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_output\_path | The default file to output backend configuration to | `string` | `"./backend.tf"` | no |
| container\_name | The Name of the Storage Container within the Storage Account. | `string` | `""` | no |
| key | The name of the Blob used to retrieve/store Terraform's State file inside the Storage Container. | `string` | `"global/terrform.tfstate"` | no |
| name\_prefix | The prefix for all created resources | `string` | `"tfstate"` | no |
| resource\_group\_name | The Name of the Resource Group in which the Storage Account exists. | `any` | n/a | yes |
| storage\_account\_name | The name of the storage account | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| key | The name of the Blob created to retrieve/store Terraform's State file inside the Storage Container |
| storage\_account\_name | Name of created storage account |
| storage\_container | Name of created storage container |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
