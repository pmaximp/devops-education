# Задание 5
output "task_5" {
  value = concat(
    [ for it in yandex_compute_instance.vms_web_count: {
       name = it.name
       id = it.id
       fqdn = it.fqdn
    }], 
    [ for it in yandex_compute_instance.vms_db_each: {
       name = it.name
       id = it.id
       fqdn = it.fqdn
    }])
}

