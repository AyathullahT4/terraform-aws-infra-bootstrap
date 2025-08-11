variable "instance_name" {}
variable "instance_type" {}
variable "aws_key_name" {}
variable "public_key_path" {}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "subnet_id" {}
variable "ami_id" {}

