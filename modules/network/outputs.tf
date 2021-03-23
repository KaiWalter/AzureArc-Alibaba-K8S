output "vpc_id" {
  value = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
}