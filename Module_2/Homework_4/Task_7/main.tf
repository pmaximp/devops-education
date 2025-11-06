# Считываем все что есть в secrets/secret/example
data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

# Подключаемся к valut и создаем в secrets каталог secret_from_terraform/ c с типом kv и версией 2
resource "vault_mount" "kvv2" {
  path        = "secret_from_terraform/"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

# Генерируем пароль
resource "random_password" "new_secret" {
  length = 17
}

# Записываем пароль в vault по пути secrets/secret_from_terraform/secret_passwd
resource "vault_kv_secret_v2" "add_secret_kv" {
  mount = vault_mount.kvv2.path
  name  = "secret_passwd"

  data_json = jsonencode(
    {
      username = "admin",
      password = "${random_password.new_secret.result}"
    }
  )
}

# Считываем снегерированный пароль из secrets/secret_from_terraform/secret_passwd
data "vault_generic_secret" "vault_example2" {
  depends_on = [vault_kv_secret_v2.add_secret_kv]
  path       = "secret_from_terraform/secret_passwd"
}
