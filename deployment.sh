#!/bin/bash -e

case $1 in
"destroy")
    ansible-playbook setup-infra.yml -e operation=destroy
    ;;
"create")
    ansible-playbook setup-infra.yml -e operation=create
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i host.ini setup-runner-environment.yml \
        -u ${TF_VAR_vm_user} --key-file '${TF_VAR_key_file}'
    ;;
esac
