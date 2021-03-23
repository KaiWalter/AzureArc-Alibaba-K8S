terraform {
  required_version = ">= 0.14"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "images" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

resource "alicloud_security_group" "group" {
  name        = var.vm_name
  description = "VM security group"
  vpc_id      = var.vpc_id
}

resource "alicloud_security_group_rule" "allow_ssh_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id            = var.vpc_id
  cidr_block        = var.vm_cidr
  availability_zone = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_key_pair" "publickey" {
  key_name          = var.vm_name

  public_key = var.vm_public_key
}

locals {
  user_data = <<EOF
#!/bin/bash

# install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az extension add --name connectedk8s
az extension add --name k8s-configuration

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install Dapr
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

# install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
EOF
}

resource "alicloud_instance" "instance" {
  instance_name     = var.vm_name

  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = [alicloud_security_group.group.id]
  instance_type              = "ecs.n2.medium"
  key_name                   = alicloud_key_pair.publickey.id
  system_disk_category       = "cloud_efficiency"
  system_disk_name           = "${var.vm_name}_disk_name"
  system_disk_description    = "${var.vm_name}_disk_description"
  image_id                   = data.alicloud_images.images.images.0.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  user_data                  = local.user_data
}
