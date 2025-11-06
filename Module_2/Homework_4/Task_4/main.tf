# Создание сети и подсетей dev контура
module "vpc_dev" {
  source       = "./module_vpc"
  env = "develop"
  network_name = var.vpc_name # опционально
  subnets      = [
    { zone = "ru-central1-a", v4_cidr_blocks = ["10.0.1.0/24"] },
    { zone = "ru-central1-b", v4_cidr_blocks = ["10.0.2.0/24"] },
    { zone = "ru-central1-d", v4_cidr_blocks = ["10.0.3.0/24"] }]
}

# Создание сети и подсетей test контура
module "vpc_test" {
  source       = "./module_vpc"
  env = "test"
  network_name = var.vpc_name # опционально
  subnets      = [
    { zone = "ru-central1-a", v4_cidr_blocks = ["10.0.1.0/24"] },
    { zone = "ru-central1-d", v4_cidr_blocks = ["10.0.3.0/24"] }]
}

# Пример обращения к элементам
output "example" {
  value = module.vpc_test.out.ru-central1-a.id
}