module "shipping" {
 source = "./modules/asg"
 project_name = var.project_name
 env = var.env
 common_tags = var.shipping_common_tags
 health_check = var.health_check
 target_group_port = var.target_group_port
 vpc_id = module.vpc.vpc_id
 image_id = data.aws_ami.devops_ami.id
 security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
 user_data = filebase64("${path.module}/shipping.sh")
 launch_template_tags = var.cart_launch_template_tags
 vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
 tag = var.shipping_autoscaling_tags
 alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
 rule_priority = 40
 host_header = "shipping.app.anikacoffee.xyz"
}