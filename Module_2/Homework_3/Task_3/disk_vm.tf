# Параметры доп. дисков
variable "vm_storage_secondary_disk" {
  type = object({
    disk_size = number
    disk_type = string
  })
  default = {
    disk_size = 1
    disk_type = "network-hdd"
  }
}

# Параметры ВМ
variable "vm_storage" {
  type = object({
    cloud_vm_name = string
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
    cloud_vm_name = "storage"
    platform_id = "standard-v2"
    family_os = "ubuntu-2004-lts"
    disk_size = 5
    disk_type = "network-hdd"
    cores = 2
    memory = 1
    core_fraction = 5
    preemptible = true
    nat = false
  }
}

# Создание дисков в количестве 3 шт
resource "yandex_compute_disk" "vm_storage" {
  count = 3
  size = var.vm_storage_secondary_disk.disk_size
  type = var.vm_storage_secondary_disk.disk_type
}

# Обращаемся к Яндекс Облаку для поиска образа
data "yandex_compute_image" "ubuntu_storage" {
  family = var.vm_storage.family_os
}

# Создание ВМ
resource "yandex_compute_instance" "vm_storage" {
  
#   # Для доступа через бастион добавлена зависимость от yandex_compute_instance.bastion
#   depends_on = [ yandex_compute_instance.bastion ]
  
  name = var.vm_storage.cloud_vm_name
  platform_id = var.vm_storage.platform_id
  
  resources {
    cores = var.vm_storage.cores
    memory = var.vm_storage.memory
    core_fraction = var.vm_storage.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.vm_storage.nat
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_storage.image_id
      size = var.vm_storage.disk_size
      type = var.vm_storage.disk_type
    }  
  }

  # Добавляем диски к ВМ созданные ранее. Зависимость не добавляю т.к. тераформ и так понимаем как сделать
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vm_storage
      content {
        disk_id = lookup(secondary_disk.value, "id", null)
      }
    }

  scheduling_policy {
    preemptible = var.vm_storage.preemptible
  }

  metadata = {
        ssh-keys = "ubuntu:${local.ssh_public_key}"
    }
}
