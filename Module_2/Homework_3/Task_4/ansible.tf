resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible.tftpl", 
  {
    webservers = yandex_compute_instance.vms_web_count
    database = yandex_compute_instance.vms_db_each
    storage = yandex_compute_instance.vm_storage
  })
  filename = "${path.module}/hosts.ini"
}
