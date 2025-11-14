resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible.tftpl",
    {
      swarm_master = module.vms_master.all
      swarm_host   = module.vms_host.all
  })
  filename = "${path.module}/hosts.ini"
}
