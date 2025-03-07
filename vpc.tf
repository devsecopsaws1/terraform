module "vpc" {
  source = "./modules/vpc"     #you can alos give github repo url where our modules have been stored.
  cidr_block = var.cidr_block
  env = var.env
  project_name = var.project_name
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  common_tags = var.common_tags
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr

}

#EC2-- VPC,SG

#gitrepo  -- module--vpc-- > push --repo--- any othere we provide repo url

#source = "./modules/vpc"  project1 ---->  2 -- github url

module "dev_prod_peering" {
  count = var.is_peering_required ? 1 : 0
  source             = "./modules/peering"
  requestor_vpc_id   = module.vpc.vpc_id
  peer_vpc_id        = data.aws_ssm_parameter.peering_vpc_id[0].value
  requestor_cidr_block = module.vpc.vpc_cider_block
  peer_cidr_block    = data.aws_ssm_parameter.vpc_cider_block[0].value #prod vpc cidr
  auto_accept        = true
  route_table_id     = module.vpc.public_route_table_id
  dest_route_table_id = data.aws_ssm_parameter.public_route_table_id[0].value
  project_name = var.project_name
  env = var.env
  common_tags = var.common_tags
  is_peering_required = var.is_peering_required
}




