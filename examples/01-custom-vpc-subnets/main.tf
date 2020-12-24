/*
*
* # Example: 01-custom-vpc-subnets
* Creates:
* - custom vpc using the module
* - public subnets in 3xAZs using the module
*
* ## Usage
*
* To run this example you need to execute:
*
* ```bash
* $ terraform init
* $ terraform plan
* $ terraform apply
* ```
*
*/

data "aws_availability_zones" "available" {}

module "simple_vpc" {
  source                     = "github.com/wheelq/tf-aws-lab-infra?ref=v0.1"
  name                       = var.name
  cidr_block                 = var.cidr_block
  enable_dns_support         = var.enable_dns_support
  enable_dns_hostnames       = var.enable_dns_hostnames
  enable_classiclink         = var.enable_classiclink
  instance_tenancy           = var.instance_tenancy
  availability_zones         = data.aws_availability_zones.available.names
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  public_map_public_ip       = var.public_map_public_ip
  public_subnet_suffix       = var.public_subnet_suffix
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  private_map_public_ip      = var.private_map_public_ip
  private_subnet_suffix      = var.private_subnet_suffix
  destination_cidr_block     = var.destination_cidr_block
  environment                = var.environment
}