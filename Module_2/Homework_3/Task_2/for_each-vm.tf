# Параметры ВМ
variable "vms_db_each" {
    type = list(object({
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
    }))
    default = [ { 
        cloud_vm_name = "main"
        platform_id = "standard-v2"
        family_os = "ubuntu-2004-lts"
        disk_size = 10
        disk_type = "network-hdd"
        cores = 2
        memory = 2
        core_fraction = 20
        preemptible = true
        nat = false
      },
      { 
        cloud_vm_name = "replica"
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
    ]
}

# Обращаемся к Яндекс Облаку для поиска образа в зависимости от ВМ
data "yandex_compute_image" "ubuntu_each" {
  for_each = { for it in var.vms_db_each: it.cloud_vm_name => it }
  family = each.value.family_os
}

# Создаем ВМ
resource "yandex_compute_instance" "vms_db_each" {
  
  # Проще сделать через dynamic
  for_each = { for it in var.vms_db_each: it.cloud_vm_name => it } 
  name = each.value.cloud_vm_name
  platform_id = each.value.platform_id

  resources {
    cores = each.value.cores
    memory = each.value.memory
    core_fraction = each.value.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = each.value.nat
  }

  boot_disk {
    initialize_params {
        # Указываем image_id в зависимости от значения it. Т.е. при первой итерации будет each.key = "main", при второй each.key = "replica"
        image_id = data.yandex_compute_image.ubuntu_each[each.key].image_id 
        size = each.value.disk_size
        type = each.value.disk_type
    }
  }
  
  scheduling_policy {
      preemptible = each.value.preemptible
  }

    metadata = {
        ssh-keys = "ubuntu:${local.ssh_public_key}"
    }
}