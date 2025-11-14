# Имя сети
variable "vpc_name" {
  type        = string
  default     = "docker_swarm_hw5"
  description = "VPC network&subnet name"
}

variable "env" {
  type = string
  default = "develop"
}

# Параметры ВМ необходимые для модуля
variable "vms" {
  type = map(object({
    instance_name  = string 
    image_family   = string
    instance_count = number
    nat_use        = bool
  }))
  default = {
    "master" = {
      instance_name  = "swarm-master"
      image_family   = "ubuntu-2004-lts"
      instance_count = 1
      nat_use        = true
    },
    "host" = {
      instance_name  = "swarm-host"
      image_family   = "ubuntu-2004-lts"
      instance_count = 2
      nat_use        = true
    }
  }
  description = "Parametr for vms module"
}