variable "location" {
  type        = string
  description = "Azure location (region) to deploy to"
  default     = "EastUS"

}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create"
  default     = "rg-api-devex-demo"

}
