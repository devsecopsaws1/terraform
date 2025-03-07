cidr_block = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support = true
env="dev"
project_name="roboshop"
public_subnet_cidr =["10.0.1.0/24","10.0.2.0/24"] #2
private_subnet_cidr = ["10.0.11.0/24","10.0.12.0/24"]
database_subnet_cidr = ["10.0.21.0/24","10.0.22.0/24"]
#bucket_name="roboshop-statefile-bucket"
sg_name = "web-sg"
sg_descritption = "security group for dynamic block"
# ingress_rules = [ {
#     from_port = 27017
#     to_port = 27017
#     protocol = "tcp" #all protocols
#     cidr_blocks = ["0.0.0.0/0"]
# },
# {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp" #all protocols
#     cidr_blocks = ["0.0.0.0/0"]
# }
# ]

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

is_peering_required = false
peering_env = "dev"