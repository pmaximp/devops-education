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