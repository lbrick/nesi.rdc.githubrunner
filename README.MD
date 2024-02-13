# NeSI RDC Github Runner

This use the role [monolithprojects.github_actions_runner](https://github.com/MonolithProjects/ansible-github_actions_runner)

## Setup

To use this repo please run the following:

``` { .sh }
ansible-galaxy install -p roles -r requirements.yml
```

This will install the required role `monolithprojects.github_actions_runner`

You will also need to set some environment variables

``` { .sh }
export TF_VAR_key_pair="KEY_PAIR_NAME"
export TF_VAR_key_file="~/.ssh/location/to/key_pair"
export TF_VAR_vm_user="cloud-user"
export AWS_ACCESS_KEY_ID="EC2_ACCESS_KEY"
export AWS_SECRET_KEY="EC2_SECRET_KEY"
export PERSONAL_ACCESS_TOKEN=GITHUB_PAT
```

`TF_VAR_key_pair` is the Key Pair name in NeSI RDC

`TF_VAR_key_file` is the Key Pair location on your local machine

`TF_VAR_vm_user` is the user for the RDC cloud image

`AWS_ACCESS_KEY_ID` and `AWS_SECRET_KEY` are EC2 credentials created on the RDC, [Creating and Managing EC2 credentials](https://support.cloud.nesi.org.nz/user-guides/create-and-manage-object-storage/creating-and-managing-ec2-credentials-via-cli/)

`PERSONAL_ACCESS_TOKEN` is a github PAT created with access to the repo created [here](https://github.com/settings/tokens)

Within the terraform directory you will also need to set the bucket name under the file `terraform/provider.tf` on line 12

You will also need to ensure you have downloaded your `clouds.yaml` from the NeSI RDC and ensure its located in `~/config/openstack`

Under the Terraform folder in the file `provider.tf` set the variable `BUCKET_NAME` to the name of your object storage insde the RDC

With those variables set you are able to run the following script

``` { .sh }
./deployment.sh create
```
