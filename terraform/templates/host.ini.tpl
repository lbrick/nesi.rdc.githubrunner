[servers]
github-runner ansible_host=${github_runner_floating_ip} hostname=${github_runner_hostname}

[servers:vars]
vm_private_key_file=${vm_private_key_file}
ansible_ssh_common_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
