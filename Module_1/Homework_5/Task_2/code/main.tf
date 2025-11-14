# Создание сетей с использование модуля (пока только в одной зоне)
module "vpc" {
  source       = "./module_vpc"
  network_name = var.vpc_name
  env          = var.env
  subnets      = [{ zone = "ru-central1-a", v4_cidr_blocks = ["10.0.1.0/24"] }]
}

# Создание мастеров docker swarm
module "vms_master" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.env
  network_id     = module.vpc.out.ru-central1-a.network_id
  subnet_ids     = [module.vpc.out.ru-central1-a.id]
  subnet_zones   = ["${module.vpc.out.ru-central1-a.zone}"]
  instance_name  = var.vms.master.instance_name
  instance_count = var.vms.master.instance_count
  image_family   = var.vms.master.image_family
  public_ip      = var.vms.master.nat_use

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# Создание воркеров docker swarm
module "vms_host" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.env
  network_id     = module.vpc.out.ru-central1-a.network_id
  subnet_ids     = [module.vpc.out.ru-central1-a.id]
  subnet_zones   = ["${module.vpc.out.ru-central1-a.zone}"]
  instance_name  = var.vms.host.instance_name
  instance_count = var.vms.host.instance_count
  image_family   = var.vms.host.image_family
  public_ip      = var.vms.host.nat_use

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
    user           = local.remote_user
  }
}

# Создаем пароли для БД
resource "random_password" "mysql_passwords" {
  count   = 2
  length  = 16
  special = false
}

resource "null_resource" "web_hosts_provision" {

  # Ждем создания инстансов
  depends_on = [module.vms_master, module.vms_host]

  # Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command    = "eval $(ssh-agent) && cat ~/.ssh/id_rsa | ssh-add -"
    on_failure = continue

  }
}

resource "null_resource" "set_docker_swarm" {

  # Запуск плейбука swarm_init_and_get_project.yml
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/swarm_init_and_get_project.yml --extra-vars 'MYSQL_ROOT_PASSWORD=${nonsensitive(random_password.mysql_passwords[0].result)} MYSQL_PASSWORD=${nonsensitive(random_password.mysql_passwords[1].result)}'"

    on_failure  = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  triggers = {
    # при изменении inventory-template
    template_rendered = "${local_file.ansible_inventory.content}" 
  }
}
