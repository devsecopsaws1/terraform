module "sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = var.common_tags
  sg_name = var.sg_name
  sg_descritption = var.sg_descritption
  ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "app-sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = var.common_tags
  sg_name = var.app_sg_name
  sg_descritption = var.sg_descritption
  ingress_rules  = var.app_ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "mongodb-sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = var.common_tags
  sg_name = var.app_sg_name
  sg_descritption = var.sg_descritption
  ingress_rules  = var.app_ingress_rules
  vpc_id = module.vpc.vpc_id

}