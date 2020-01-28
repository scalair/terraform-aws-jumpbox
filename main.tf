terraform {
  required_version = ">= 0.12.0"
}

resource "aws_security_group" "jump" {
  description = "Allow SSH to the jumpbox"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.aws_security_group_cidr_blocks
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.aws_security_group_jump_tags
}

resource "aws_instance" "jump" {
  ami                         = var.aws_instance_ami
  instance_type               = var.aws_instance_instance_type
  key_name                    = var.aws_instance_key_name
  vpc_security_group_ids      = [aws_security_group.jump.id]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = var.aws_instance_volume_size
  }

  tags = var.aws_instance_jump_tags
}

resource "aws_eip" "jump" {
  instance = aws_instance.jump.id
  vpc      = true
  
  tags = var.aws_eip_jump_tags
}
