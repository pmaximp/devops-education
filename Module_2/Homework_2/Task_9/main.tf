## Создание сетей/подсетей ##
resource "yandex_vpc_network" "develop" {
  name = var.vms_network.web.name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vms_network.web.name
  zone           = var.vms_network.web.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_network.web.v4_cidr_blocks
  route_table_id = yandex_vpc_route_table.route_table.id
}
resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vms_network.db.name
  zone           = var.vms_network.db.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_network.db.v4_cidr_blocks
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "permanma-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "route_table" {
  name = "permanma-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id = yandex_vpc_gateway.nat_gateway.id
  }
}

## Создание ВМ ##
/* WEB */
data "yandex_compute_image" "ubuntu" {
  family = var.vms_resources.web.family
}
resource "yandex_compute_instance" "platform" {
  name        = "${var.vms_resources.web.cloud_vm_name}-${var.vm_creator}"
  platform_id = var.vms_resources.web.platform
  zone        = var.vms_network.web.default_zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_network.web.nat
  }

  metadata = var.connect_data.web

}

/* DB */
data "yandex_compute_image" "ubuntu_db" {
  family = var.vms_resources.db.family
}
resource "yandex_compute_instance" "platform_db" {
  name        = "${var.vms_resources.db.cloud_vm_name}-${var.vm_creator}"
  platform_id = var.vms_resources.db.platform
  zone        = var.vms_network.db.default_zone
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.db.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = var.vms_network.db.nat
  }

  metadata = var.connect_data.db

}