# Create github_runner instance
resource "openstack_compute_instance_v2" "github_runner_instance" {
  name            = "github-runner"
  flavor_id       = var.github_runner_flavor_id
  key_pair        = var.key_pair
  security_groups = ["default", "ssh-allow-all", "https", "http"]

  block_device {
    uuid                  = var.github_runner_image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    volume_size           = var.github_runner_volume_size
    delete_on_termination = true
  }

  network {
    name = var.tenant_name
  }
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "github_runner_floating_ip" {
  pool  = "external"
}

# Assign floating ip
resource "openstack_compute_floatingip_associate_v2" "github_runner_floating_ip_association" {
  floating_ip  = openstack_networking_floatingip_v2.github_runner_floating_ip.address
  instance_id  = openstack_compute_instance_v2.github_runner_instance.id
}

# add extra public keys to github_runner instance
resource "null_resource" "github_runner_extra_keys" {
  depends_on = [openstack_compute_floatingip_associate_v2.github_runner_floating_ip_association]
  count = length(var.extra_public_keys) > 0 ? 1 : 0

  connection {
    user = var.vm_user
    private_key = file(var.key_file)
    host = "${openstack_networking_floatingip_v2.github_runner_floating_ip.address}"
  }

  provisioner "remote-exec" {
    inline = [for pkey in var.extra_public_keys : "echo ${pkey} >> $HOME/.ssh/authorized_keys"]
  }
}

# Generate ansible hosts
locals {
  host_ini_all = templatefile("${path.module}/templates/all-hosts.tpl", {
    github_runner_floating_ip = openstack_networking_floatingip_v2.github_runner_floating_ip.address,
    github_runner_hostname = "github-runner"
    vm_private_key_file = var.key_file
  })
}

# Generate ansible host.ini file
locals {
  host_ini_content = templatefile("${path.module}/templates/host.ini.tpl", {
    github_runner_floating_ip = openstack_networking_floatingip_v2.github_runner_floating_ip.address,
    github_runner_hostname = "github-runner"
    vm_private_key_file = var.key_file
  })
}

resource "local_file" "host_ini" {
  filename = "../host.ini"
  content  = "${local.host_ini_all}\n${local.host_ini_content}"
  file_permission = "0644"
}
