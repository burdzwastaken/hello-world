variable "environment" {}

variable "region" {}

variable "vpc_id" {}

variable "base_security_group" {}

variable "zone_id" {}

variable "private_subnets" {}

variable "public_subnets" {}

variable "ssh_public_key_name" {}

variable "role" {
  default = "burdz-hello-world"
}

variable "cluster_size" {
  default = "1"
}

variable "instance_port" {
  default = "8080"
}

variable "instance_type" {
  default = "m3.medium"
}

variable "architecture" {
  default = "x86_64"
}

variable "virtualization_type" {
  default = "hvm"
}

variable "root_device_type" {
  default = "ebs"
}

variable "storage_type" {
  default = "gp2"
}
