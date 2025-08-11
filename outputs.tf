output "instance_public_ip" {
  value = module.ec2_nginx.public_ip
}

output "alb_dns_name" {
  value = module.alb_asg.alb_dns_name
}

