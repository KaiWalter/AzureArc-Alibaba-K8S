provider "alicloud" {}

module "managed-k8s" {
  source            = "terraform-alicloud-modules/managed-kubernetes/alicloud"

  k8s_name_prefix = "azure-arc-poc"
  new_vpc         = true
  vpc_cidr        = "192.168.0.0/16"
  vswitch_cidrs = [
    "192.168.1.0/24",
  ]
  worker_instance_types = ["ecs.n2.medium"]
  new_sls_project = true

  kube_config_path = "~/.kube/config"

  cluster_addons = [
   {
     name   = "flannel",
     config = "",
   },
   {
     name   = "flexvolume",
     config = "",
   },
   {
     name   = "alicloud-disk-controller",
     config = "",
   },
   {
     name   = "logtail-ds",
     config = "{\"IngressDashboardEnabled\":\"true\"}",
   },
   {
     name   = "nginx-ingress-controller",
     config = "{\"IngressSlbNetworkType\":\"internet\"}",
   },
 ]
}

module "jumpvm" {
  source = "../modules/vm"
  vm_name = "azure-arc-poc-jump"
  vpc_id = module.managed-k8s.this_vpc_id
  vm_cidr = "192.168.0.0/24"
  vm_public_key = file("~/.ssh/id_rsa.pub")
}
