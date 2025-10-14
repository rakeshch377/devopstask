# IAM roles
resource "aws_iam_role" "eks_cluster" {
  name = "eksClusterRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{Effect="Allow",Principal={Service="eks.amazonaws.com"},Action="sts:AssumeRole"}]
  })
}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Cluster
resource "aws_eks_cluster" "reactapp" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config { subnet_ids = var.subnet_ids }
}

# Node group role
resource "aws_iam_role" "node_role" {
  name = "eksNodeRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{Effect="Allow",Principal={Service="ec2.amazonaws.com"},Action="sts:AssumeRole"}]
  })
}

resource "aws_iam_role_policy_attachment" "node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])
  role       = aws_iam_role.node_role.name
  policy_arn = each.value
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.reactapp.name
  node_group_name = "reactapp-workers"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = ["t3.medium"]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

