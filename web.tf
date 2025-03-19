resource "aws_lb_target_group" "web" {
    name     = "${var.project_name}-${var.web_common_tags.Component}"
    port     = 80
    protocol = "HTTP"
    vpc_id   = module.vpc.vpc_id
    health_check {
        enabled = true
        path                = "/"
        port                = 80
        protocol            = "HTTP"
        timeout             = 5
        interval            = 15
        healthy_threshold   = 2
        unhealthy_threshold = 3
        matcher = "200-299"
    }
  
}

resource "aws_launch_template" "web" {
    name   = "${var.project_name}-${var.web_common_tags.Component}"
    description   = "Launch Template for Web Service"
    image_id      = data.aws_ami.devops_ami.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
    user_data = filebase64("${path.module}/web.sh")
    tag_specifications  {
        resource_type = "instance"
        tags = merge(var.web_common_tags,{
          Name = "Web"
     })
    }
  
}

resource "aws_autoscaling_group" "web" {
  name = "${var.project_name}-${var.web_common_tags.Component}"
  min_size = 1
  max_size = 2
  desired_capacity = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.web.arn]
  vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Web"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "web_scaleout" {
  autoscaling_group_name = aws_autoscaling_group.web.name
  name = "policy_cpu"
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

  
}

resource "aws_lb_listener_rule" "web" {
  listener_arn = data.aws_ssm_parameter.web_alb_listener_arn.value
  priority = 10
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

