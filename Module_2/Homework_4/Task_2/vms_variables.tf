# Имя сети
variable "vpc_name" {
  type        = string
  default     = "develop-networks-perman"
  description = "VPC network&subnet name"
}

# Параметры подсетей
variable "vms_network" {
  type = list(object({
    zone = string
    v4_cidr_blocks = list(string)
  }))
  default = [ {
    zone = "ru-central1-a"
    v4_cidr_blocks = [ "10.0.1.0/24" ]
  },
  {
    zone = "ru-central1-b"
    v4_cidr_blocks = [ "10.0.2.0/24" ]
  } ]
}

# Параметры ВМ необходимые для модуля
variable "vms" {
  type = map(object({
    instance_name  = string
    image_family   = string
    env            = string
    instance_count = number
    labels         = map(string)
    nat_use        = bool
  }))
  default = {
    "marketing" = {
      instance_name  = "marketing-vm"
      image_family   = "ubuntu-2004-lts"
      env            = "test"
      instance_count = 1
      labels          = { project = "marketing" }
      nat_use        = true
    }
    "analytics" = {
      instance_name  = "analytics-vm"
      image_family   = "ubuntu-2004-lts"
      env            = "delevop"
      instance_count = 1
      labels          = { project = "analytics" }
      nat_use        = true
    }
  }
  description = "Parametr for vms module"
}