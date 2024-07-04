terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-luis1"
    key    = "state"
    region = "us-east-1"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = tolist(data.aws_subnets.default.ids)[0]
  vpc_security_group_ids = [aws_security_group.main.id]  # Usar vpc_security_group_ids
  key_name = "my-ssh-key"

  user_data = <<-EOF
                #!/bin/bash
                apt-get update
                apt-get install -y docker.io docker-compose
                aws s3 cp s3://your-bucket/docker-compose.yml /home/ubuntu/docker-compose.yml
                cd /home/ubuntu
                docker-compose up -d
                EOF

  tags = {
    Name = "Application Instance"
  }
}