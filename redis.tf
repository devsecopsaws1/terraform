module "redis_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.devops_ami.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
    subnet_id = local.db_subnet_id
    user_data = file("redis.sh")
    tags = merge(var.common_tags, {
        Name = "redis"
    })  
}

#mongodb.anikacoffee.xyz  privateip0fabove instance

module "record_redis"{
    source = "terraform-aws-modules/route53/aws//modules/records"
    zone_name = var.zone_name
    records = [{
        name = "redis"
        type = "A"
        ttl = "10"
        records = [module.redis_instance.private_ip]

    }]
}