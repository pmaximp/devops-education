variable "folder_id" {
  type    = string
  default = "${env("YC_FOLDER_ID")}"
}

variable "subnet_id" {
  type    = string
  default = "${env("YC_SUBNET_ID")}"
}

variable "oauth_tocken" {
  type    = string
  default = "${env("YC_TOCKEN")}"
}

source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = var.folder_id
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = var.subnet_id
  token               = var.oauth_tocken
  use_ipv4_nat        = true
  zone                = "ru-central1-b"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = ["echo 'hello from packer'"]
  }

  provisioner "shell" {
    scripts = ["scripts/install-docker.sh"]
  }

  provisioner "shell" {
    inline = ["sudo apt install -y htop tmux"]
  }

  provisioner "shell" {
    scripts = ["scripts/cleanup.sh"]
  }

}
