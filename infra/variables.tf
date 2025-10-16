variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "aws_account_id" {
  description = "Your AWS account ID"
  type        = string
}


