module "mongodb_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "MongoDB"
      "Component" = "MongoDB"
    })
  sg_name = "mongodb"
  sg_descritption = "SG for MongoDB"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}


module "redis_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "Redis"
      "Component" = "Redis"
    })
  sg_name = "Redis"
  sg_descritption = "SG for Redis"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}


module "mysql_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "MySQL"
      "Component" = "MySQL"
    })
  sg_name = "MySQL"
  sg_descritption = "SG for MySQL"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}


module "rabbitmq_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "RaabitMQ"
      "Component" = "RabbitMQ"
    })
  sg_name = "RaabitMQ"
  sg_descritption = "SG for RabbitMQ"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "catalogue_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "Catalogue"
      "Component" = "Catalogue"
    })
  sg_name = "Catalogue"
  sg_descritption = "SG for Catalogue"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "cart_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "Cart"
      "Component" = "Cart"
    })
  sg_name = "Cart"
  sg_descritption = "SG for Cart"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "user_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "User"
      "Component" = "User" 
    })
  sg_name = "User"
  sg_descritption = "SG for User"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "shipping_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "Shipping"
      "Component" = "Shipping"
    })
  sg_name = "Shipping"
  sg_descritption = "SG for Shipping"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "payment_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "Payment"
    })
  sg_name = "Payment"
  sg_descritption = "SG for Payment"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "alb_sg" {
  source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
  env = var.env
  project_name = var.project_name
  common_tags = merge (
    var.common_tags,{
      "Name" = "App-ALB"
      "Component" = "ALB"
    })
  sg_name = "ALB"
  sg_descritption = "SG for ALB"
   #ingress_rules  = var.ingress_rules
  vpc_id = module.vpc.vpc_id

}

module "web_sg" {
    source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
    env = var.env
    project_name = var.project_name
    common_tags = merge (
        var.common_tags,{
        "Name" = "Web"
        "Component" = "Web"
        })
    sg_name = "Web"
    sg_descritption = "SG for Web"
     #ingress_rules  = var.ingress_rules
    vpc_id = module.vpc.vpc_id
}

module "web_alb_sg" {
    source = "./modules/securitygroup"   #you can alos give github repo url where our modules have been stored.
    env = var.env
    project_name = var.project_name
    common_tags = merge (
        var.common_tags,{
        "Name" = "Web-ALB"
        "Component" = "Web-ALB"
        })
    sg_name = "Web-ALB"
    sg_descritption = "SG for Web-ALB"
     #ingress_rules  = var.ingress_rules
    vpc_id = module.vpc.vpc_id 
}


resource "aws_security_group_rule" "mongodb_catalogue" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = module.catalogue_sg.sg_id
  security_group_id = module.mongodb_sg.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = module.user_sg.sg_id
  security_group_id = module.mongodb_sg.sg_id
  
}

resource "aws_security_group_rule" "redis_user" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = module.user_sg.sg_id
  security_group_id = module.redis_sg.sg_id
  
}

resource "aws_security_group_rule" "redis_cart" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = module.cart_sg.sg_id
  security_group_id = module.redis_sg.sg_id
  
}

resource "aws_security_group_rule" "mysql_shipping" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = module.shipping_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
  
}

resource "aws_security_group_rule" "rabbimq_payment" {
  type = "ingress"
  from_port = 5672
  to_port = 5672
  protocol = "tcp"
  source_security_group_id = module.payment_sg.sg_id
  security_group_id = module.rabbitmq_sg.sg_id
  
}

resource "aws_security_group_rule" "catalogue_alb" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security_group_id = module.alb_sg.sg_id
    security_group_id = module.catalogue_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_web" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = module.web_sg.sg_id
    security_group_id = module.alb_sg.sg_id
}


resource "aws_security_group_rule" "web_alb_internet" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.web_alb_sg.sg_id
  
}

resource "aws_security_group_rule" "web_web_alb" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = module.web_alb_sg.sg_id
    security_group_id = module.web_sg.sg_id
  
}

resource "aws_security_group_rule" "user_alb" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security_group_id = module.alb_sg.sg_id
    security_group_id = module.user_sg.sg_id
  
}

resource "aws_security_group_rule" "cart_alb" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security_group_id = module.alb_sg.sg_id
    security_group_id = module.cart_sg.sg_id
  
}

resource "aws_security_group_rule" "alb_cart" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = module.cart_sg.sg_id
    security_group_id = module.alb_sg.sg_id
  
}

resource "aws_security_group_rule" "alb_user" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = module.user_sg.sg_id
    security_group_id = module.alb_sg.sg_id
  
}

resource "aws_security_group_rule" "shipping_alb" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security_group_id = module.alb_sg.sg_id
    security_group_id = module.shipping_sg.sg_id
  
}

resource "aws_security_group_rule" "alb_shipping" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    source_security_group_id = module.shipping_sg.sg_id
    security_group_id = module.alb_sg.sg_id
  
}