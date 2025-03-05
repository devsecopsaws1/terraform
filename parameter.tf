resource "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.env}/vpc_id"
  type = "String"
  value = module.vpc.vpc_id

}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.env}/public_subnet_ids"
  type = "StringList"
  value = join(",",module.vpc.public_subnet_ids) #list=[1,2,3] === 1,2,3 == 1, 2, 3
    
  }

  resource "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.env}/private_subnet_ids"
  type = "StringList"
  value = join(",",module.vpc.private_subnet_ids) #list=[1,2,3] === 1,2,3 == 1, 2, 3
    
  }

  resource "aws_ssm_parameter" "vpc_cider_block" {
  name = "/${var.project_name}/${var.env}/vpc_cider_block"
  type = "String"
  value = module.vpc.vpc_cider_block

}

resource "aws_ssm_parameter" "public_route_table_id" {
  name = "/${var.project_name}/${var.env}/public_route_table_id"
  type = "String"
  value = module.vpc.public_route_table_id

}