# IAM roles and policies for EKS & service accounts (IRSA)
resource "aws_iam_role" "eks_node_role" {
  name = "${var.environment}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume.json
}

data "aws_iam_policy_document" "eks_node_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
