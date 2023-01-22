terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver"

  # (parameters hidden for clarity)

  cluster_name           = "htunn-devops-uat"
  db_remote_state_bucket = "htunn-terraform-uat"
  db_remote_state_key    = "uat/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 3
  max_size      = 3
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

