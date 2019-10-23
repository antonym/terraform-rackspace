# Terraform using Rackspace Public Cloud for Gitlab Runners

Used for registering gitlab runners with Terraform and
Rackspace Cloud

```
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars to your environment
# edit main.tf to adjust any first boot commands
# create a workspace
terraform workspace new runners
terraform workspace select runners
# create an ssh keypair for terraform-<workspace>
ssh-keygen -f ~/.ssh/terraform-runners
terraform init
terraform plan
terraform apply
```

If you need to group other runners for other projects, simply add
a new workspace and change to that workspace.  The state of
terraform will be saved in the workspace.

Runners should pop up in gitlab instance automatically.  To
increase the runner count, bump up the count variable and
run terraform apply.  This will provision additional runners
as needed and spin down the rest.
