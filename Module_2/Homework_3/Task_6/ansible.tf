resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", 
  {
    webservers = yandex_compute_instance.vms_web_count
    database = yandex_compute_instance.vms_db_each
    storage = yandex_compute_instance.vm_storage
    bastion = yandex_compute_instance.bastion
  })
  filename = "${path.module}/hosts.ini"
}
