# Remote State Locking Azure
A terraform module to automate creation and configuration of backend using azure blob


## Basic Usage 

```hcl
module "remote_state_locking" {
  source   = "git::https://gitlab.com/deimosdev/tooling/terraform-modules/terraform-remote-state-azure"
  location = var.aws_region
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | ~> 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.0.0 |
| null | >= 2.1 |
| random | >= 2.1 |
| template | >= 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_output\_path | The default file to output backend configuration to | `string` | `"./backend.tf"` | no |
| container\_name | The Name of the Storage Container within the Storage Account. | `string` | `""` | no |
| key | The name of the Blob used to retrieve/store Terraform's State file inside the Storage Container. | `string` | `"global/terrform.tfstate"` | no |
| name\_prefix | The prefix for all created resources | `string` | `"tfstate-"` | no |
| resource\_group\_location | The location of resource group | `any` | n/a | yes |
| resource\_group\_name | The Name of the Resource Group in which the Storage Account exists. | `string` | `""` | no |
| storage\_account\_name | The name of the storage account | `string` | `""` | no |

## Outputs

No output.

