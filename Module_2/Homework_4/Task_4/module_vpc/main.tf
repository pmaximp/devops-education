#создаем облачную сеть
resource "yandex_vpc_network" "network" {
  name = "${var.network_name}-${var.env}"
}
  
#создаем подсеть
resource "yandex_vpc_subnet" "subnet" {
  for_each = {for it in var.subnets: it.zone => it}
  name           = "${var.network_name}-${var.env}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = each.value.v4_cidr_blocks
}
