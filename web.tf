resource "aws_lb_target_group" "web" {
  name     = "${var.project_name}-${var.web_common_tags.Component}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    enabled = true
    healthy_threshold = 2 # consider as healthy if 2 health checks are success
    interval = 15
    matcher = "200-299"
    path = "/"
    port = 80
    protocol = "HTTP"
    timeout = 5
    unhealthy_threshold = 3
  }
}

resource "aws_launch_template" "web" {
  name = "${var.project_name}-${var.web_common_tags.Component}"

  image_id = data.aws_ami.devops_ami.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Web"
    }
  }

  user_data = filebase64("${path.module}/web.sh")
}

resource "aws_autoscaling_group" "web" {
  name                      = "${var.project_name}-${var.web_common_tags.Component}"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  target_group_arns = [aws_lb_target_group.web.arn]
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  vpc_zone_identifier       = split(",",data.aws_ssm_parameter.private_subnet_ids.value)

  tag {
    key                 = "Name"
    value               = "Web"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "web" {
  autoscaling_group_name = aws_autoscaling_group.web.name
  name                   = "cpu"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}

resource "aws_lb_listener_rule" "web" {
  listener_arn = data.aws_ssm_parameter.web_alb_listener_arn.value
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

  condition {
    host_header {
      values = ["anikacoffee.xyz"]
    }
  }
}

# module "web" {
#   source = "./modules/asg"   #you can alos give github repo url where our modules have been stored.
#   project_name = var.project_name
#   env = var.env
#   web_common_tags = var.web_common_tags

#   #target group
#   health_check = var.health_check
#   target_group_port = var.target_group_port
#   vpc_id = module.vpc.vpc_id

#   #launch template
#   image_id = data.aws_ami.devops_ami.id
#   security_group_id = data.aws_ssm_parameter.web_sg_id.value
#   user_data = filebase64("${path.module}/web.sh")
#   launch_template_tags = var.launch_template_tags

#   #autoscaling
#   vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
#   tag = var.autoscaling_tags

#   #autoscalingpolicy, I am good with optional params

#   #listener rule
#   alb_listener_arn = data.aws_ssm_parameter.web_alb_listener_arn.value
#   rule_priority = 10
#   host_header = "anikacoffee.xyz"

# }

