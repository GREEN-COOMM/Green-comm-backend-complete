variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.medium"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-08005652b282676ac"
}