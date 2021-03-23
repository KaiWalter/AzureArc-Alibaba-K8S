resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count             = length(var.vswitch_ids) > 0 ? 0 : length(var.vswitch_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.vswitch_cidrs, count.index)
  availability_zone = element(var.availability_zone, count.index)
}


# According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "terway_vswitches" {
  count             = length(var.terway_vswitch_ids) > 0 ? 0 : length(var.terway_vswitch_cirds)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.terway_vswitch_cirds, count.index)
  availability_zone = element(var.availability_zone, count.index)
}

resource "alicloud_cs_managed_kubernetes" "k8s" {
  name                  = var.cluster_name
  resource_group_id     = var.resource_group_id
  version               = "1.18.8-aliyun.1"
  worker_vswitch_ids    = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids)) : length(var.vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.vswitches.*.id))
  pod_vswitch_ids       = length(var.terway_vswitch_ids) > 0 ? split(",", join(",", var.terway_vswitch_ids)) : length(var.terway_vswitch_cirds) < 1 ? [] : split(",", join(",", alicloud_vswitch.terway_vswitches.*.id))
  worker_instance_types = var.worker_instance_types
  worker_number         = var.worker_number
  node_cidr_mask        = var.node_cidr_mask
  enable_ssh            = var.enable_ssh
  install_cloud_monitor = var.install_cloud_monitor
  cpu_policy            = var.cpu_policy
  proxy_mode            = var.proxy_mode
  password              = random_password.password.result
  service_cidr          = var.service_cidr

  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name   = lookup(addons.value, "name", var.cluster_addons)
      config = lookup(addons.value, "config", var.cluster_addons)
    }
  }
  runtime = {
    name    = "docker"
    version = "19.03.5"
  }
}
