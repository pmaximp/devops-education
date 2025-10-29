# Параметры ВМ
variable "vm_bastion" {
  type = object({
    cloud_vm_name = string
    hostname_vm_name = string
    platform_id = string
    family_os = string
    disk_size = number
    disk_type = string
    cores = number
    memory = number
    core_fraction = number
    preemptible = bool
    nat = bool
  })
  default = {
    cloud_vm_name = "bastion"
    hostname_vm_name = "srv-bastion"
    platform_id = "standard-v2"
    family_os = "ubuntu-2004-lts"
    disk_size = 5
    disk_type = "network-hdd"
    cores = 2
    memory = 1
    core_fraction = 5
    preemptible = true
    nat = true
  }
}

# Создавать ли bastion-сервер да/нет Если создавать есть, то на всех ВМ nat = false, если не создаем то nat = true
variable "external_acess_bastion" {
  type    = bool
  default = true
}

# Применять ли ansible playbook да/нет 
variable "provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}

# Обращаемся к Яндекс Облаку для поиска образа
data "yandex_compute_image" "ubuntu_bastion" {
  family = var.vms_web_count.family_os
}

# Создание bastion'a
resource "yandex_compute_instance" "bastion" {
  count = var.external_acess_bastion ? 1 : 0

  name        = var.vm_bastion.cloud_vm_name
  hostname    = var.vm_bastion.hostname_vm_name
  platform_id = var.vm_bastion.platform_id

  resources {
    cores         = var.vm_bastion.cores
    memory        = var.vm_bastion.memory
    core_fraction = var.vm_bastion.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_bastion.nat
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_bastion.image_id
      type     = var.vm_bastion.disk_type
      size     = var.vm_bastion.disk_size
    }
  }

  scheduling_policy {
      preemptible = var.vm_bastion.preemptible
  }

  metadata = {
      ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

}

# Создаем лист имен всех инстансов ВМ
locals {
  vms_name = concat([for it in yandex_compute_instance.vms_db_each: it.name], [for it in yandex_compute_instance.vms_web_count: it.name], [yandex_compute_instance.vm_storage.name])
}

# Создаем пароль для каждого инстанса ВМ
resource "random_password" "each" {
  for_each    = toset(local.vms_name)
  length = 17
}

resource "null_resource" "hosts_provision" {
  count = var.provision == true ? 1 : 0
 
  # Ничего не делать пока не создадутся инстансы
  depends_on = [yandex_compute_instance.vms_db_each, yandex_compute_instance.vms_web_count, yandex_compute_instance.vm_storage, yandex_compute_instance.bastion]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command    = "eval $(ssh-agent) && cat ~/.ssh/id_rsa | ssh-add -"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок

  }
  # Запуск ansible-playbook
  provisioner "local-exec" {
    command = "ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/test.yml --extra-vars '{\"secrets\": ${nonsensitive(jsonencode({ for k, v in random_password.each : k => v.result }))} }'"
    on_failure  = continue 
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  triggers = {
    always_run = "${timestamp()}"
    # template_rendered = "${local_file.ansible_inventory.content}" #при изменении inventory-template
  }
}