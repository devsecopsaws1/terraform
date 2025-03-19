resource "aws_lb" "web_alb" {
    name               = "${var.project_name}-${var.env}-web-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    =  [data.aws_ssm_parameter.web_alb_sg_id.value] #[module.alb_sg.sg_id]
    subnets            = split(",",data.aws_ssm_parameter.public_subnet_ids.value) #-- subnet1,subnet2,subnet
    #enable_deletion_protection = false
    tags = merge(var.common_tags, var.alb_common_tags)
}

resource "aws_lb_listener" "frontend" {
    load_balancer_arn = aws_lb.web_alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "This is getting served from Web ALB"
            status_code  = "200"
        }
    }
}

module "record_web"{
    source = "terraform-aws-modules/route53/aws//modules/records"
    zone_name = var.zone_name
    records = [{
        name = "" 
        type = "A"
        alias = {
            name = aws_lb.web_alb.dns_name
            zone_id = aws_lb.web_alb.zone_id
        }
        

    }]
}

#catalouge.anikacoffee.xyz --- LB -- target group of catalogue