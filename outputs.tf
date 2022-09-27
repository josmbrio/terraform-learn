output "aws_ami" {
  value = module.myapp-server.ami_image.id
}

output "ec2_public_ip" {
  value = module.myapp-server.instance.public_ip
}