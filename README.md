
# Terraform AWS Lab Infra  
Create customised VPCs with subnets and routing for lab purposes

## Usage
```
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
```

## Examples
- [examples](examples/)

## Requirements

| Name | Version |
|------|---------|
| terraform | > 0.13.3 |
| aws | ~> 3.22.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability_zones | Availability zones in scope | `list(string)` | n/a | yes |
| cidr_block | VPC CIDR block | `string` | n/a | yes |
| destination_cidr_block | Destination CIDR for ingress | `string` | n/a | yes |
| enable_classiclink | Classic link: should be disabled | `bool` | n/a | yes |
| enable_dns_hostnames | Enable DNS for hostnames | `bool` | n/a | yes |
| enable_dns_support | Enable DNS support | `bool` | n/a | yes |
| environment | Environment name | `string` | n/a | yes |
| instance_tenancy | Instance tenancy. default: default | `string` | n/a | yes |
| name | Name of the custom VPC | `string` | n/a | yes |
| private_map_public_ip | Enable public IP | `bool` | n/a | yes |
| private_subnet_cidr_blocks | Subnet CIDR blocks | `list(string)` | n/a | yes |
| private_subnet_suffix | Suffix to append to subnets name | `string` | n/a | yes |
| public_map_public_ip | Enable public IP | `bool` | n/a | yes |
| public_subnet_cidr_blocks | Subnet CIDR blocks | `list(string)` | n/a | yes |
| public_subnet_suffix | Suffix to append to subnets name | `string` | n/a | yes |
| subnet_tags | Additional tags for the subnets | `map(string)` | `{}` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| vpc_tags | Additional tags for the VPC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | Custom VPC id |
