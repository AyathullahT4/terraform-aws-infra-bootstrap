module "ec2_nginx" {
  source        = "./modules/ec2-nginx"
  instance_name = var.instance_name
  instance_type = var.instance_type
  aws_key_name  = var.aws_key_name
  public_key_path = var.public_key_path
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id     = var.subnet_id
  ami_id        = var.ami_id
}

module "alb_asg" {
  source         = "./modules/alb-asg"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids
  alb_sg_id      = var.alb_sg_id
}

