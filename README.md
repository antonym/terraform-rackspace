# Terraform using Rackspace Public Cloud for Gitlab Runners

Used for registering gitlab runners with Terraform and
Rackspace Cloud

```
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars to your environment
# edit main.tf to adjust any first boot commands
terraform init
terraform plan
terraform apply
```

Runners should pop up in gitlab instance automatically.  To
increase the runner count, bump up the count variable and
run terraform apply.  This will provision additional runners
as needed and spin down the rest.
