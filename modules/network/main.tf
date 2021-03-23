# If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count             = var.vpc_id == "" ? 1 : 0
  cidr_block        = var.vpc_cidr
  resource_group_id = var.resource_group_id
}
