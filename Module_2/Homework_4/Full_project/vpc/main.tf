# Создание сетей с использование модуля 
module "vpc_dev" {
  source       = "../module_vpc"
  env          = "develop"
  network_name = var.vpc_name
  subnets = [
    { zone = "ru-central1-a", v4_cidr_blocks = ["10.0.1.0/24", "10.0.4.0/24"] },
    { zone = "ru-central1-b", v4_cidr_blocks = ["10.0.2.0/24"] }]
}

module "vpc_test" {
  source       = "../module_vpc"
  env          = "test"
  network_name = var.vpc_name
  subnets = [
    { zone = "ru-central1-b", v4_cidr_blocks = ["10.0.2.0/24"] }]
}
