module "vpc" {
  source = "./modules/vpc"   #you can alos give github repo url where our modules have been stored.
  cidr_block = var.cidr_block
  env = var.env
  project_name = var.project_name
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  common_tags = var.common_tags
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

}

#EC2-- VPC,SG

#gitrepo  -- module--vpc-- > push --repo--- any othere we provide repo url

#source = "./modules/vpc"  project1 ---->  2 -- github url


