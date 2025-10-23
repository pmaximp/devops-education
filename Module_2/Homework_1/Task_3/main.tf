terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "~> 3.0.1"
        }
    }
}

provider "docker" {
  host     = "ssh://permanma@158.160.187.80:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "random_password" "password_generate" {
   length = 10
   count = 2
}

resource "docker_image" "mysql_perm_image" {
    name = "mysql:8"
}

resource "docker_container" "mysql_perm_cont" {
    name = "permanma_mysql_docker_tofu"
    image = docker_image.mysql_perm_image.image_id
    
    env = [
        "MYSQL_ROOT_PASSWORD=${random_password.password_generate[0].result}",
        "MYSQL_DATABASE=db_tofu_perm",
        "MYSQL_USER=perman",
        "MYSQL_PASSWORD=${random_password.password_generate[1].result}",
        "MYSQL_ROOT_HOST=\"%\""
    ]

    ports {
        internal = 3306
        external = 3306
        ip = "127.0.0.1"
    }
}