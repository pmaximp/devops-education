###cloud vars


variable "cloud_id" {
  type        = string
  default = "<cloud id>"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default = "<cloud folder id>"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<ssh public key>"
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name on cloud"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v2"
  description = "VM platform_id"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}

variable "vm_web_cores" {
  type = number
  default = 2
  description = "VM cores"
}

variable "vm_web_ram" {
  type = number
  default = 1
  description = "VM RAM"
}

variable "vm_web_core_fraction" {
  type = number
  default = 5
  description = "VM core fraction"
}

variable "vm_web_preemptible_mode" {
  type = bool
  default = true
  description = "Preemptinle mode state"
}

variable "vm_web_nat_mode" {
  type = bool
  default = true
  description = "Nat mode state"
}