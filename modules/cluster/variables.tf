variable "resource_group_id" {
  type = string
}

variable "availability_zone" {
  type    = list(any)
  default = []
}
variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vswitch_cidrs" {
  type    = list(any)
}

variable "vswitch_ids" {
  type    = list(any)
  default = []
}

variable "terway_vswitch_cirds" {
  type    = list(any)
  default = []
}

variable "terway_vswitch_ids" {
  type    = list(any)
  default = []
}

variable "cluster_addons" {
  type    = list(any)
  default = []
}

variable "service_cidr" {
  default = "172.21.0.0/20"
}

variable "node_cidr_mask" {
  default = "26"
}

variable "proxy_mode" {
  default = "ipvs"
}

variable "cpu_policy" {
  default = "none"
}

variable "enable_ssh" {
  default = false
}

variable "install_cloud_monitor" {
  default = true
}

variable "worker_number" {
  default = 3
}

variable "worker_instance_types" {
  default = [
    "ecs.n2.medium"
  ]
}
