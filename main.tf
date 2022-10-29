terraform {
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

resource "aws_instance" "zeek" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  #security_groups = ["launch-wizard-1",]
  key_name = "zeek"
  vpc_security_group_ids = ["sg-02db4659f1613f093",]
  subnet_id = "subnet-010cbcffbba89a1e7"
  user_data = <<EOF
    #!/bin/bash
    echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/security:zeek.list
    curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null
    sudo apt update -y
    sudo apt install zeek-lts -y
  EOF
  tags = {
    Name = "zeek"
  } 
}