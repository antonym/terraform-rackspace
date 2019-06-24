# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "${var.user_name}"
  tenant_id   = "${var.tenant_id}"
  password    = "${var.password}"
  auth_url    = "${var.auth_url}"
  region      = "${var.region}"
}

resource "openstack_compute_keypair_v2" "terraform" {
  name       = "terraform"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_compute_instance_v2" "mnaio-runners" {
  count     = "${var.server_count}"
  name      = "${format("${var.instance_prefix}-%02d", count.index+1)}"
  region    = "${var.region}"
  image_id  = "${var.image}"
  flavor_id = "${var.flavor}"
  key_pair  = "${openstack_compute_keypair_v2.terraform.name}"

  network {
    uuid = "00000000-0000-0000-0000-000000000000"
    name = "public"
  }
  network {
    uuid = "11111111-1111-1111-1111-111111111111"
    name = "private"
  }

  provisioner "remote-exec" {
  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file("~/.ssh/terraform")}"
    host        = "${self.network.0.fixed_ip_v4}"
    }

    inline = [
      "echo '    ServerAliveInterval 60' >> /etc/ssh/ssh_config",
      "apt-get update -y -qq",
      "dpkg-reconfigure libc6",
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get -q --option \"Dpkg::Options::=--force-confold\" --assume-yes install libssl1.1",
      "wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64",
      "chmod +x /usr/local/bin/gitlab-runner",
      "mkdir -p /opt/gitlab-runner",
      "gitlab-runner install --user=root",
      "RUNNER_NAME=${self.name} RUNNER_TAG_LIST=${var.gitlab_runner_tags} CI_SERVER_URL=${var.gitlab_server_url} REGISTRATION_TOKEN=${var.gitlab_runner_token} RUNNER_EXECUTOR=${var.gitlab_executor_type} REGISTER_NON_INTERACTIVE=true gitlab-runner register",
      "gitlab-runner start"
    ]
  }
}
