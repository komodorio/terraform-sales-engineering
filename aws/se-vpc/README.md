# SE-VPC

Deploys a VPC with public and private subnets across multiple availability zones, along with necessary networking 
components such as Internet Gateway, NAT Gateway, route tables, and security groups.

Resources are automatically tagged for identification. You can also add your own tags using the `tags` variable.

## Usage

```hcl
module "se_vpc" {
  source   = "https://github.com/komodorio/terraform-sales-engineering//aws/se-vpc"
  vpc_name = "my-se-vpc"
  tags = {
    Environment = "Production"
    Project     = "MyProject"
  }
}
```