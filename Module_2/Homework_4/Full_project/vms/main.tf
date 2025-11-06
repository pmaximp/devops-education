# Создаем виртуальную машину в проекте marketing с использование модуля
module "marketing-vm" {
  source       = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name     = var.vms.marketing.env
  network_id   = local.vpc_test.ru-central1-b.network_id
  subnet_ids   = [local.vpc_test.ru-central1-b.id]
  subnet_zones = ["${local.vpc_test.ru-central1-b.zone}"]
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
  source       = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name     = var.vms.analytics.env
  network_id   = local.vpc_dev.ru-central1-a.network_id
  subnet_ids   = [local.vpc_dev.ru-central1-a.id, local.vpc_dev.ru-central1-b.id]
  subnet_zones = ["${local.vpc_dev.ru-central1-a.zone}", "${local.vpc_dev.ru-central1-b.zone}"]
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