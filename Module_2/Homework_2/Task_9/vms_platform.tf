# ## WEB ##
# variable "vm_web_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "VM name on cloud"
# }

# variable "vm_web_platform" {
#   type        = string
#   default     = "standard-v2"
#   description = "VM platform_id"
# }

# variable "vm_web_family" {
#   type        = string
#   default     = "ubuntu-2004-lts"
#   description = "VM image"
# }

# variable "vm_web_cores" {
#   type = number
#   default = 2
#   description = "VM cores"
# }

# variable "vm_web_ram" {
#   type = number
#   default = 1
#   description = "VM RAM"
# }

# variable "vm_web_core_fraction" {
#   type = number
#   default = 5
#   description = "VM core fraction"
# }

# variable "vm_web_preemptible_mode" {
#   type = bool
#   default = true
#   description = "Preemptinle mode state"
# }

# variable "vm_web_nat_mode" {
#   type = bool
#   default = true
#   description = "Nat mode state"
# }

# ## DB ##

# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "VM name on cloud"
# }

# variable "vm_db_platform" {
#   type        = string
#   default     = "standard-v2"
#   description = "VM platform_id"
# }

# variable "vm_db_family" {
#   type        = string
#   default     = "ubuntu-2004-lts"
#   description = "VM image"
# }

# variable "vm_db_cores" {
#   type = number
#   default = 2
#   description = "VM cores"
# }

# variable "vm_db_ram" {
#   type = number
#   default = 2
#   description = "VM RAM"
# }

# variable "vm_db_core_fraction" {
#   type = number
#   default = 20
#   description = "VM core fraction"
# }

# variable "vm_db_preemptible_mode" {
#   type = bool
#   default = true
#   description = "Preemptinle mode state"
# }

# variable "vm_db_nat_mode" {
#   type = bool
#   default = true
#   description = "Nat mode state"
# }

# variable "vm_db_default_zone" {
#   type        = string
#   default     = "ru-central1-b"
#   description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
# }
# variable "vm_db_default_cidr" {
#   type        = list(string)
#   default     = ["10.0.2.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

# variable "vm_db_subnet_name" {
#   type        = string
#   default     = "develop-b"
#   description = "VPC network & subnet name"
# }

## ALL ##

variable "vm_creator" {
    type      = string
    default   = "permanma"
}

variable "vms_resources" {
    type = map(object({
        platform = string
        family = string
        cloud_vm_name = string
        cores = number
        memory = number
        core_fraction = number
        preemptible = bool
    }))
    default = {
      "web" = {
        platform = "standard-v2"
        family = "ubuntu-2004-lts"
        cloud_vm_name = "netology-develop-platform-web"
        cores = 2
        memory = 1
        core_fraction = 5
        preemptible = true
      },
      "db" = {
        platform = "standard-v2"
        family = "ubuntu-2004-lts"
        cloud_vm_name = "netology-develop-platform-db"
        cores = 2
        memory = 2
        core_fraction = 20
        preemptible = true
      } 
    }
}

variable "vms_network" {
    type = map(object({
        name = string
        default_zone = string
        v4_cidr_blocks = list(string)
        nat = bool
    }))

    default = {
      "web" = {
        name = "develop"
        default_zone = "ru-central1-a"
        v4_cidr_blocks = ["10.0.1.0/24"]
        nat = false
      },
      "db" = {
        name = "develop-b"
        default_zone = "ru-central1-b"
        v4_cidr_blocks = ["10.0.2.0/24"]
        nat = false
      }
    }
}

variable "connect_data" {
    type = map(object({
        serial-port-enable = number
        ssh-keys = string
    }))
    default = { 
        "web" = {
            serial-port-enable = 1
            ssh-keys           = "ubuntu:<ssh public key>"
        },
        "db" = {
            serial-port-enable = 1
            ssh-keys           = "ubuntu:<ssh public key>"
        }
        
    }
}