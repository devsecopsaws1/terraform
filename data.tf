data "aws_ssm_parameter" "peering_vpc_id" {
  name = var.peering_env == "prod"  ? "/${var.project_name}/${var.peering_env}/vpc_id" : null
}

data "aws_ssm_parameter" "vpc_cider_block" {
  name = var.peering_env == "prod"  ? "/${var.project_name}/${var.peering_env}/vpc_cider_block" : null
}


data "aws_ssm_parameter" "public_route_table_id" {
  name = var.peering_env == "prod"  ? "/${var.project_name}/${var.peering_env}/public_route_table_id" : null
}