variable "ami_id" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}

