locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}
locals {
  remote_user = "ubuntu"
}
