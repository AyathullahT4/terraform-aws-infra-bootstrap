resource "aws_key_pair" "deployer" {
  key_name   = var.aws_key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name      = aws_key_pair.deployer.key_name

  user_data     = file("${path.module}/user_data.sh")

  tags = {
    Name = var.instance_name
  }
}

