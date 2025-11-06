# Имя сети default в случае если не задано иное
variable "network_name" {
  type    = string
  default = "default_from_module"
}

# Пустая переменная с опредленным типом для. Без указания создать подсеть нельзя
variable "zone" {
  type = string
}

# Параметры подсети в случае если не задано иное
variable "v4_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
