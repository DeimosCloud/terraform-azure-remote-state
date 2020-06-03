variable "key" {
  description = "The name of the Blob used to retrieve/store Terraform's State file inside the Storage Container."
  default     = "global/terrform.tfstate"
}

variable "name_prefix" {
  description = "The prefix for all created resources"
  default     = "tfstate-"
}

variable "resource_group_name" {
  description = "The Name of the Resource Group in which the Storage Account exists."
  default     = ""
}

variable "resource_group_location" {
  description = "The location of resource group"
}

variable "container_name" {
  description = "The Name of the Storage Container within the Storage Account."
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the storage account"
  default     = ""
}

variable "backend_output_path" {
  default     = "./backend.tf"
  description = "The default file to output backend configuration to"
}

