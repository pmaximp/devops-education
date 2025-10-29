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

# Задание 9
output "task_9_p1" {
  value = [ for it in range(1, 100, 1):
    it <= 9 ? "rc0${it}" : "rc${it}"
  ]
}

output "task_9_p2" {
  value = compact([ for it in range(1, 100, 1):
    (it % 10 != 0 && it % 10 != 8 && it % 10 != 7) && ( it % 10 != 9 || it == 19 ) ? it <= 9 ? "rc0${it}" : "rc${it}" : ""
  ])
}