provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "latest_eks" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name = "my-cluster"
  subnets      = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  vpc_id       = "vpc-abcde012"

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "m4.large"
      key_name      = "my-key-name"
      ami_id        = data.aws_ami.latest_eks.id

      additional_tags = {
        Environment = "test"
        Name        = "eks-worker-node"
      }
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

data "helm_repository" "jetstack" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = data.helm_repository.jetstack.metadata[0].name
  chart      = "cert-manager"
  version    = "v1.5.0"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

data "helm_repository" "envoy" {
  name = "envoy"
  url  = "https://envoyproxy.github.io/helm-charts"
}

resource "helm_release" "envoy" {
  name       = "envoy"
  repository = data.helm_repository.envoy.metadata[0].name
  chart      = "envoy"
  version    = "0.18.3"
}

