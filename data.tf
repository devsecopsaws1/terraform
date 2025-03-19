data "aws_ssm_parameter" "peering_vpc_id" {
  depends_on = [ aws_ssm_parameter.vpc_id ]
  count = var.is_peering_required ? 1 : 0
  name = var.peering_env == "prod"  ? "/${var.project_name}/${var.peering_env}/vpc_id" : null
}

data "aws_ssm_parameter" "vpc_cider_block" {
  depends_on = [ aws_ssm_parameter.vpc_cider_block ]
  count = var.is_peering_required ? 1 : 0
  name = var.peering_env == "prod"  ? "/${var.project_name}/${var.peering_env}/vpc_cider_block" : null
}


data "aws_ssm_parameter" "public_route_table_id" {
  depends_on = [ aws_ssm_parameter.public_route_table_id ]
  count = var.is_peering_required ? 1 : 0
  name = var.peering_env == "prod"  ? "/${var.project_name}/${var.peering_env}/public_route_table_id" : null
}

data "aws_ssm_parameter" "app_alb_sg_id" {
  depends_on = [ aws_ssm_parameter.app_alb_sg_id ]
  name = "/${var.project_name}/${var.env}/app_alb_sg_id"
  
}


data "aws_ssm_parameter" "private_subnet_ids" {
  depends_on = [aws_ssm_parameter.private_subnet_ids]
  name = "/${var.project_name}/${var.env}/private_subnet_ids"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  depends_on = [ aws_ssm_parameter.public_subnet_ids ]
  name = "/${var.project_name}/${var.env}/public_subnet_ids"
  
}
data "aws_ssm_parameter" "database_subnet_ids" {
  depends_on = [ aws_ssm_parameter.database_subnet_ids ]
  name = "/${var.project_name}/${var.env}/database_subnet_ids"
  
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  depends_on = [ aws_ssm_parameter.mongodb_sg_id ]
  name = "/${var.project_name}/${var.env}/mongodb_sg_id"
  
}

data "aws_ssm_parameter" "catalogue_sg_id" {
  depends_on = [ aws_ssm_parameter.catalogue_sg_id ]
  name = "/${var.project_name}/${var.env}/catalogue_sg_id"
  
}

data "aws_ssm_parameter" "app_alb_listener_arn" {
  depends_on = [ aws_ssm_parameter.app_alb_listener_arn ]
  name = "/${var.project_name}/${var.env}/app_alb_listener_arn"
  
}

data "aws_ssm_parameter" "web_alb_sg_id" {
  depends_on = [ aws_ssm_parameter.web_alb_sg_id ]
  name = "/${var.project_name}/${var.env}/web_alb_sg_id"
}

data "aws_ssm_parameter" "web_sg_id" {
  depends_on = [ aws_ssm_parameter.web_sg_id ]
  name = "/${var.project_name}/${var.env}/web_sg_id"
  
}

data "aws_ssm_parameter" "web_alb_listener_arn" {
    depends_on = [ aws_ssm_parameter.web_alb_listener_arn ]
    name = "/${var.project_name}/${var.env}/web_alb_listener_arn"
}

data "aws_ssm_parameter" "redis_sg_id" {
  depends_on = [ aws_ssm_parameter.redis_sg_id ]
  name = "/${var.project_name}/${var.env}/redis_sg_id"
  
}

data "aws_ssm_parameter" "mysql_sg_id" {
  depends_on = [ aws_ssm_parameter.mysql_sg_id ]
  name = "/${var.project_name}/${var.env}/mysql_sg_id"
  
}

data "aws_ssm_parameter" "user_sg_id" {
  depends_on = [ aws_ssm_parameter.user_sg_id ]
  name = "/${var.project_name}/${var.env}/user_sg_id"
  
}

data "aws_ssm_parameter" "shipping_sg_id" {
  depends_on = [ aws_ssm_parameter.shipping_sg_id ]
  name = "/${var.project_name}/${var.env}/shipping_sg_id"
  
}

data "aws_ssm_parameter" "cart_sg_id" {
  depends_on = [ aws_ssm_parameter.cart_sg_id ]
  name = "/${var.project_name}/${var.env}/cart_sg_id"
  
}
# data "aws_ssm_parameter" "peering_vpc_id" {
#   name = (var.peering_env == "prod" || var.peering_env == "stage") ? "/${var.project_name}/${var.peering_env}/vpc_id" : null
# }

data "aws_ami" "devops_ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
