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

  resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/${var.env}/database_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.database_subnet_ids) # module should have output declaration
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

resource "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.env}/app_alb_sg_id"
    type = "String"
    value = module.alb_sg.sg_id
  
}

resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project_name}/${var.env}/mongodb_sg_id"
  type  = "String"
  value = module.mongodb_sg.sg_id     # module should have output declaration
}

resource "aws_ssm_parameter" "app_alb_listener_arn" {
  name  = "/${var.project_name}/${var.env}/app_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.http.arn    # module should have output declaration
  
}

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.project_name}/${var.env}/catalogue_sg_id"
  type  = "String"
  value = module.catalogue_sg.sg_id # module should have output declaration
}

resource "aws_ssm_parameter" "web_sg_id" {
  name  = "/${var.project_name}/${var.env}/web_sg_id"
  type  = "String"
  value = module.web_sg.sg_id # module should have output declaration
}

resource "aws_ssm_parameter" "web_alb_sg_id" {
  name  = "/${var.project_name}/${var.env}/web_alb_sg_id"
  type  = "String"
  value = module.web_alb_sg.sg_id # module should have output declaration
}

resource "aws_ssm_parameter" "web_alb_listener_arn" {
  name  = "/${var.project_name}/${var.env}/web_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.front_end.arn # module should have output declaration
}