##########################################
# Root Terraform Configuration
##########################################

##########################################
# VPC Module
##########################################
module "vpc" {
  source = "./modules/vpc"
}

##########################################
# EKS Module
##########################################
module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.public_subnets
  key_pair     = var.key_pair_name
}

##########################################
# ECR Repository
##########################################
resource "aws_ecr_repository" "reactapp" {
  name                 = "reactapp"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "reactapp-ecr"
    Environment = "dev"
  }
}

##########################################
# Outputs
##########################################
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.reactapp.repository_url
}

