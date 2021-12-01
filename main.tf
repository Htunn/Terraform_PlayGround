locals {
  vpc_id           = "vpc-0163585345c5eaec9"
  subnet_id        = "subnet-045863fc5ed7f2a91"
  ssh_user         = "ubuntu"
  key_name         = "aws_ec2"
  private_key_path = "aws_ec2.pem"
}

terraform {
  backend "remote" {
    organization = "htunnthuthu"

    workspaces {
      name = "my-app-prod"
    }
  }
}
provider "aws" {
  profile = "DevAdmin"
  region  = "ap-southeast-1"
}

resource "aws_security_group" "nginx" {
  name   = "nginx_access"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami                         = "ami-055147723b7bca09a"
  subnet_id                   = local.subnet_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx.id]
  key_name                    = local.key_name

  tags = {
    Name = "webserver"
  }
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.nginx.public_ip},' --private-key ${local.private_key_path} nginx.yaml"

  }
}

output "nginx_ip" {
  value = aws_instance.nginx.public_ip
}