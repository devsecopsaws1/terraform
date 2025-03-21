module "cart" {
 source = "./modules/asg"
 project_name = var.project_name
 env = var.env
 common_tags = var.cart_common_tags
 health_check = var.health_check
 target_group_port = var.target_group_port
 vpc_id = module.vpc.vpc_id
 image_id = data.aws_ami.devops_ami.id
 security_group_id = data.aws_ssm_parameter.cart_sg_id.value
 user_data = filebase64("${path.module}/cart.sh")
 launch_template_tags = var.cart_launch_template_tags
 vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
 tag = var.cart_autoscaling_tags
 alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
 rule_priority = 30
 host_header = "cart.app.anikacoffee.xyz"
}