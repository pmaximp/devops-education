data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {

    path = "../vpc/terraform.tfstate"
  }
}

# Переопределяем переменные для удобства обращения к remote state file
locals {
  vpc_dev = data.terraform_remote_state.vpc.outputs.out[0].out
}

locals {
  vpc_test = data.terraform_remote_state.vpc.outputs.out[1].out
}

