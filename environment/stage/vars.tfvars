cidr_block = "10.3.0.0/24"
enable_dns_hostnames = true
enable_dns_support = true
env="stage"
project_name="roboshop"
public_subnet_cidr =["10.3.0.0/26","10.3.0.64/26"] #2
private_subnet_cidr = ["10.3.0.128/26","10.3.0.192/26"]
#bucket_name="roboshop-statefile-bucket"