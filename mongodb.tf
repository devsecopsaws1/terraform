module "mongodb_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.devops_ami.id
    instance_type = "t2.medium"
    vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
    subnet_id = local.db_subnet_id
    user_data = file("mongodb.sh")
    tags = merge(var.common_tags, {
        Name = "mongodb"
    })  
}

#mongodb.anikacoffee.xyz  privateip0fabove instance

module "record_mongodb"{
    source = "terraform-aws-modules/route53/aws//modules/records"
    zone_name = var.zone_name
    records = [{
        name = "mongodb"
        type = "A"
        ttl = "10"
        records = [module.mongodb_instance.private_ip]

    }]
}