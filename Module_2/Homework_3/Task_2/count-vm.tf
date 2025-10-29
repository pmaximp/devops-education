# Параметры ВМ
variable "vms_web_count" {
  type = object({
    count = number
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
    count = 2
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

# Обращаемся к Яндекс Облаку для поиска образа
data "yandex_compute_image" "ubuntu_count" {
  family = var.vms_web_count.family_os
}

# Создание ВМ
resource "yandex_compute_instance" "vms_web_count" {
  count = var.vms_web_count.count
  
  # Добавляем зависимость от compute_instance.vms_web_each. Для доступа через бастион добавлена зависимость от yandex_compute_instance.bastion
  depends_on = [ yandex_compute_instance.vms_db_each ]
  
  name = "web${count.index+1}"
  platform_id = var.vms_web_count.platform_id

  resources {
    cores = var.vms_web_count.cores
    memory = var.vms_web_count.memory
    core_fraction = var.vms_web_count.core_fraction
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.vms_web_count.nat
    # Назначаем группу безопасности созданную ранее
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  boot_disk {
    initialize_params {
        image_id = data.yandex_compute_image.ubuntu_count.image_id
        size = var.vms_web_count.disk_size
        type = var.vms_web_count.disk_type
    }
  }

  scheduling_policy {
      preemptible = var.vms_web_count.preemptible
  }

    metadata = {
        ssh-keys = "ubuntu:${local.ssh_public_key}"
    }
}