# Имя сети default в случае если не задано иное
variable "network_name" {
  type    = string
  default = "default_from_module"
}

variable "env" {
  type = string
}

variable "subnets" {
  type = list(object({
    zone           = string
    v4_cidr_blocks = list(string)
  }))
  default = [{
    zone           = "ru-central1-a",
    v4_cidr_blocks = ["10.0.1.0/24"]
  }]
}
