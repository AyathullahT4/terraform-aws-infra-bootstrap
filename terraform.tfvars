instance_name           = "nginx-bootstrap-instance"
instance_type           = "t2.micro"
aws_key_name            = "EC2KeyPair_TF_Managed"
public_key_path         = "~/.ssh/id_rsa.pub"
vpc_security_group_ids  = ["sg-0a2a4b12322822aa7"]
subnet_id               = "subnet-038a9f2c8535cf8d4"
ami_id                  = "ami-08a6efd148b1f7504"  # Amazon Linux 2
alb_sg_id   = "sg-0665d7c0e48bf7f55"
subnet_ids  = ["subnet-038a9f2c8535cf8d4", "subnet-0b6629ae0da8a8fed"]
vpc_id      = "vpc-04367ff4426e9c434"

