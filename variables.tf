variable "image" {
    default = "6258d64f-64eb-4244-843e-01e92c66d1b2"
}

variable "flavor" {
    default = "2"
}

variable "region" {
    default = "IAD"
}

variable "auth_url" {
    default = "https://identity.api.rackspacecloud.com/v2.0/"
}

variable "user_name" {
    type = "string"
}

variable "tenant_id" {
    type = "string"
}

variable "password" {
    type = "string"
}

variable "server_count" {
    default = 1
}

variable "keypair_name" {
    default = "terraform"
}

variable "instance_prefix" {
    default = "server"
}

variable "ssh_key_file" {
  default = "~/.ssh/terraform"
}

variable "gitlab_server_url" {
  default = "https://gitlab.com/"
}

variable "gitlab_runner_tags" {
  default = "runner"
}

variable "gitlab_runner_token" {
  type = "string"
}

variable "gitlab_executor_type" {
  default = "shell"
}
