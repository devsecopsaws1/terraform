resource "aws_lb" "app_alb" {
    name               = "${var.project_name}-${var.env}-app-alb"
    internal           = true
    load_balancer_type = "application"
    security_groups    =  [data.aws_ssm_parameter.app_alb_sg_id.value] #[module.alb_sg.sg_id]
    subnets            = split(",",data.aws_ssm_parameter.private_subnet_ids.value ) #-- subnet1,subnet2,subnet
    #enable_deletion_protection = false
    tags = merge(var.common_tags, var.alb_common_tags)
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app_alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "This is getting served from App ALB"
            status_code  = "200"
        }
    }
}

module "record_alb"{
    source = "terraform-aws-modules/route53/aws//modules/records"
    zone_name = var.zone_name
    records = [{
        name = "*.app" # *.app.anikacoffee.xyz catalogues.app.anikacoffee.xyz cart.app.anikacoffee.xyz
        type = "A"
        alias = {
            name = aws_lb.app_alb.dns_name
            zone_id = aws_lb.app_alb.zone_id
        }
        

    }]
}

#catalouge.anikacoffee.xyz --- LB -- target group of catalogue