# Выводим все что получили от vault
output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

# Выводим все что получили от vault
output "vault_example2" {
  value = [nonsensitive(data.vault_generic_secret.vault_example2.data.username), nonsensitive(data.vault_generic_secret.vault_example2.data.password)]
}
