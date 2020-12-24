/*
*
* # Terraform AWS Lab Infra
* Create customised VPCs with subnets and routing for lab purposes
*
* ## Usage
* ```
* data "aws_availability_zones" "available" {}
*
* module "simple_vpc" {
*   source                     = "github.com/wheelq/tf-aws-beta?ref=v0.1"
*   name                       = var.name
*   cidr_block                 = var.cidr_block
*   enable_dns_support         = var.enable_dns_support
*   enable_dns_hostnames       = var.enable_dns_hostnames
*   enable_classiclink         = var.enable_classiclink
*   instance_tenancy           = var.instance_tenancy
*   availability_zones         = data.aws_availability_zones.available.names
*   public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
*   public_map_public_ip       = var.public_map_public_ip
*   public_subnet_suffix       = var.public_subnet_suffix
*   private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
*   private_map_public_ip      = var.private_map_public_ip
*   private_subnet_suffix      = var.private_subnet_suffix
*   destination_cidr_block     = var.destination_cidr_block
*   environment                = var.environment
* }
* ```
*
* ## Examples
* - [examples](examples/)
*
*/

module "custom_vpc" {
  source               = "github.com/wheelq/tf-aws-lab-modules//custom_vpc?ref=v.01"
  name                 = var.name
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink
  instance_tenancy     = var.instance_tenancy
  environment          = var.environment
}

module "public_subnets" {
  source             = "github.com/wheelq/tf-aws-lab-modules//subnets?ref=v.01"
  name               = var.name
  vpc_id             = module.custom_vpc.vpc_id
  availability_zones = var.availability_zones
  subnet_cidr_blocks = var.public_subnet_cidr_blocks
  map_public_ip      = var.public_map_public_ip
  subnet_suffix      = var.public_subnet_suffix
  subnet_tags        = var.subnet_tags
  environment        = var.environment
}

module "private_subnets" {
  source             = "github.com/wheelq/tf-aws-lab-modules//subnets?ref=v.01"
  name               = var.name
  vpc_id             = module.custom_vpc.vpc_id
  availability_zones = var.availability_zones
  subnet_cidr_blocks = var.private_subnet_cidr_blocks
  map_public_ip      = var.private_map_public_ip
  subnet_suffix      = var.private_subnet_suffix
  subnet_tags        = var.subnet_tags
  environment        = var.environment
}

module "public_routing" {
  source                 = "github.com/wheelq/tf-aws-lab-modules//routing?ref=v.01"
  name                   = var.name
  vpc_id                 = module.custom_vpc.vpc_id
  subnets                = module.public_subnets.subnets_ids
  destination_cidr_block = var.destination_cidr_block
  environment            = var.environment
}