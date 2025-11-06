#создаем облачную сеть
resource "yandex_vpc_network" "network" {
  name = "${var.network_name}-${var.zone}"
}

#создаем подсеть
resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.network_name}-${var.zone}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.v4_cidr
}
