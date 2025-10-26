## WEB ##
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

## DB ##

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM name on cloud"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v2"
  description = "VM platform_id"
}

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}

variable "vm_db_cores" {
  type = number
  default = 2
  description = "VM cores"
}

variable "vm_db_ram" {
  type = number
  default = 2
  description = "VM RAM"
}

variable "vm_db_core_fraction" {
  type = number
  default = 20
  description = "VM core fraction"
}

variable "vm_db_preemptible_mode" {
  type = bool
  default = true
  description = "Preemptinle mode state"
}

variable "vm_db_nat_mode" {
  type = bool
  default = true
  description = "Nat mode state"
}

variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_subnet_name" {
  type        = string
  default     = "develop-b"
  description = "VPC network & subnet name"
}

## ALL ##

variable "vm_creator" {
    type      = string
    default   = "permanma"
}