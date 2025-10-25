locals {
  base_tags = {
    clickOps = "false"
    longLived = "false"
    moduleRepo = "github.com/komodorio/terraform-sales-engineering/aws/se-vpc"
  }

  merged_tags = var.tags != null ? merge(local.base_tags, var.tags) : local.base_tags
}

module vpc {
  source   = "github.com/komodorio/terraform-sales-engineering//aws/se-vpc"
  vpc_name = "testtesttest"
  tags     = local.merged_tags
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.6.1"

  vpc_id = module.vpc.vpc.vpc_id
  name = "amazing-first-cluster"

  # Disable EKS Auto Mode
  compute_config = {
    enabled = false
  }

  kubernetes_version = "1.33"
  tags = local.merged_tags
  #endpoint_public_access = false
  endpoint_public_access  = true
  endpoint_private_access = true
  control_plane_subnet_ids = module.vpc.vpc.public_subnets
  subnet_ids = module.vpc.vpc.public_subnets
  enable_cluster_creator_admin_permissions = true
  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }
  eks_managed_node_groups = {
    control_plane = {
      ami_type = "AL2023_x86_64_STANDARD"
      min_size     = 3
      max_size     = 3
      desired_size = 3
      instance_types   = ["t3.medium"]

      disk_size        = 20
      subnet_ids       = module.vpc.vpc.public_subnets
      tags = local.merged_tags
    }

    amd64_nodes = {
      min_size     = 2
      max_size     = 2
      desired_size = 2
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types   = ["t3.medium"]

      disk_size        = 20
      subnet_ids       = module.vpc.vpc.public_subnets
      tags = local.merged_tags
    }
  }
}