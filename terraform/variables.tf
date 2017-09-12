variable "environment" {
  default = "dev"  
}

variable "region" {
  default = "us-west-2"
}

variable "vpc_id" {
  default = "vpc-b3fa6cd6"
}

variable "zone_id" {
  default = "ZTQ3TT9KTV36"
}

variable "ssh_public_key_name" {
  default = "burdz"
}

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
