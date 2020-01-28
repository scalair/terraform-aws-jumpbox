####################
# VPC remote state #
####################
variable "vpc_bucket" {
  description = "Name of the bucket where vpc state is stored"
}

variable "vpc_state_key" {
  description = "Key where the state file of the VPC is stored"
}

variable "vpc_state_region" {
  description = "Region where the state file of the VPC is stored"
}

##################
# Security group #
##################
variable "aws_security_group_cidr_blocks" {
  description = "List of CIDR to allow SSH from"
  type        = list
}

variable "aws_security_group_jump_tags" {
  description = "Set of tags to be added to the jump SG"
  type        = map(string)
  default     = {}
}

##############
# Elastic IP #
##############
variable "aws_eip_jump_tags" {
  description = "Set of tags to be added to the jump EIP"
  type        = map(string)
  default     = {}
}

############
# Instance #
############
variable "aws_instance_instance_type" {
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
  default     = "t2.nano"
}

variable "aws_instance_ami" {
  description = "The AMI to use for the instance"
}

variable "aws_instance_key_name" {
  description = "The key name of the Key Pair to use for the instance"
}

variable "aws_instance_volume_size" {
  description = "The size of the volume in gibibytes (GiB)"
  type        = string
  default     = "30"
}

variable "aws_instance_jump_tags" {
  description = "Set of tags to be added to the jump instance"
  type        = map(string)
  default     = {}
}
