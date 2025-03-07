cidr_block = "10.4.0.0/24"
enable_dns_hostnames = true
enable_dns_support = true
env="prod"
project_name="roboshop"
public_subnet_cidr =["10.4.0.0/26","10.4.0.64/26"] #2
private_subnet_cidr = ["10.4.0.128/26","10.4.0.192/26"]
#bucket_name="roboshop-statefile-bucket"

app_sg_name = "app-sg"
app_ingress_rules = [ {
    from_port = 0
    to_port = 0
    protocol = "-1" #all protocols
    cidr_blocks = ["0.0.0.0/0"]
},
{
    from_port = 80
    to_port = 80
    protocol = "tcp" #all protocols
    cidr_blocks = ["0.0.0.0/0"]
}
]

sg_name = "web-sg"
sg_descritption = "security group for dynamic block"
is_peering_required = false
peering_env = "prod"