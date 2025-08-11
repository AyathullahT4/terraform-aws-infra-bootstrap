variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "instance_name" {}
variable "instance_type" {}
variable "aws_key_name" {}
variable "public_key_path" {}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "subnet_id" {}
variable "ami_id" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}

