locals {
  base_tags = {
    clickOps = "false"
    longLived = "false"
    moduleRepo = "github.com/komodorio/terraform-sales-engineering/aws/se-vpc"
  }

  merged_tags = var.tags != null ? merge(local.base_tags, var.tags) : local.base_tags
  vpc_name = "${var.vpc_name}-${random_string.this.result}"
}

resource "random_string" "this" {
  special = false
  length = 8
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  tags = local.merged_tags
}