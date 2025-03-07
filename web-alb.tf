resource "aws_lb" "web_alb" {
  name               = "${var.project_name}-${var.web_alb_common_tags.Component}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.web_alb_sg_id.value]
  subnets            = split(",",data.aws_ssm_parameter.public_subnet_ids.value)

  tags = var.common_tags
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  # This will add one listener on port no 80 and one default rule
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is the fixed response from Web ALB"
      status_code  = "200"
    }
  }
}

module "web_alb_records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = "anikacoffee.xyz"

  records = [
    {
      name    = ""
      type    = "A"
      alias   = {
        name    = aws_lb.web_alb.dns_name
        zone_id = aws_lb.web_alb.zone_id
      }
    }
  ]
}

