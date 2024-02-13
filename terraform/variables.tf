variable "tenant_name" {
  description = "FlexiHPC project Name"
  default = "NeSI-Training-Test"
}

variable "auth_url" {
  description = "FlexiHPC authentication URL"
  default = "https://keystone.akl-1.cloud.nesi.org.nz/v3"
}

variable "region" {
  description = "FlexiHPC region"
  default = "akl-1"
}

variable "key_pair" {
  description = "FlexiHPC SSH Key Pair name"
}

variable "key_file" {
  description = "Path to local SSH private key associated with Flexi key_pair, used for provisioning"
}

variable "github_runner_flavor_id" {
  description = "FlexiHPC Flavor ID for github_runner instance, Defaults to balanced1.2cpu4ram"
  default     = "6b2e76a8-cce0-4175-8160-76e2525d3d3d" 
}

variable "github_runner_image_id" {
  description = "FlexiHPC Image ID for github_runner instance, Defaults to NeSI-FlexiHPC-Rocky-9.3_cloud"
  default     = "01ffaabf-c3eb-4c47-8198-280d308e2bc5" 
}

variable "github_runner_volume_size" {
  description = "The size of the github_runner volume in gigabytes, defaults to 30"
  default     = "30" 
}

variable "vm_user" {
  description = "FlexiHPC VM user"
  default = "ubuntu"
}

variable "extra_public_keys" {
  description = "Additional SSH public keys to add to the authorized_keys file on provisioned nodes"
  type = list(string)
  default = []
}
