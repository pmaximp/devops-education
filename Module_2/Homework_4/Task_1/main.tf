#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#создаем подсеть в зоне ru-central1-a в сети develop
resource "yandex_vpc_subnet" "develop_a" {
  name           = "${var.vpc_name}-${var.vms_network[0].zone}"
  zone           = var.vms_network[0].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_network[0].v4_cidr_blocks
}

#создаем подсеть в зоне ru-central1-b в сети develop
resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-${var.vms_network[1].zone}"
  zone           = var.vms_network[1].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_network[1].v4_cidr_blocks
}

# Создаем виртуальную машину в проекте marketing с использование модуля
module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vms.marketing.env
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = var.vms_network[*].zone
  subnet_ids     = [yandex_vpc_subnet.develop_a.id, yandex_vpc_subnet.develop_b.id]
  instance_name  = var.vms.marketing.instance_name
  instance_count = var.vms.marketing.instance_count
  image_family   = var.vms.marketing.image_family
  public_ip      = var.vms.marketing.nat_use

  labels = var.vms.marketing.labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

# Создаем виртуальную машину в проекте analytics с использование модуля
module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vms.analytics.env
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["${var.vms_network[0].zone}"]
  subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  instance_name  = var.vms.analytics.instance_name
  instance_count = var.vms.analytics.instance_count
  image_family   = var.vms.analytics.image_family
  public_ip      = var.vms.analytics.nat_use

  labels = var.vms.analytics.labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

# Настраиваем созданную ВМ с помощью cloud-init передав значение ключа из локальной переменной ssh_public_key
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_public_key = local.ssh_public_key
  }
}
