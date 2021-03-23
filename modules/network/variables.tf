variable "resource_group_id" {
  type = string
}

variable "availability_zone" {
  type    = list(any)
  default = []
}

variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

