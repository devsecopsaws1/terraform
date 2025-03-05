variable "cidr_block" {
  description = "CIDR Block for the VPC"
  type = string   #datatype of the variable
}

variable "env" {
   type=string  
}

variable "project_name" {
   type=string  
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type = bool #datatype of the variable
  
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type = bool #datatype of the variable
  
}

# variable "availability_zone" {
#   description = "Availability Zone for the Subnet"
#   type = string
# }
variable "common_tags" {
  description = "Tags for the VPC"
  type = map(string)  #datatype of the variable and it is a key and value pair
  default = {
    "Billing" = "Platform"
  }
}

variable "public_subnet_cidr" {
  description = "CIDR Block for the Subnet"
  type = list(string)
}

variable "private_subnet_cidr" {
  description = "CIDR Block for the Subnet"
  type = list(string)
}

# variable "route_table_cidr_block" {
#   description = "CIDR Block for the Route Table"
#   type = string
#   default     = "0.0.0.0/0"
  
# }
# variable "tags_subnet" {
#   description = "Tags for the Subnet"
#   type = map(string)
#   default     = {
#     project_name = "roboshop"
#     environment  = "dev"
#     "Name" = "roboshop-vpc-subnet"
#   }
  
# }

# variable "tags_route_table" {
#   description = "Tags for the Route Table"
#   type = map(string)
#   default     = {
#     project_name = "roboshop"
#     environment  = "dev"
#     "Name" = "roboshop-route-table"
#   }
  
# }

# variable "tags_igw" {
#   description = "Tags for the Internet Gateway"
#   type = map(string)
#   default     = {
#     project_name = "roboshop"
#     environment  = "dev"
#     "Name" = "roboshop-igw"
#   } 
  
# }


# ##################################
#  # variables for Sg.tf {
# #################################
 
#  variable "sg_name" {
#    description = "Name of the Security Group"
#    type = string
#     default     = "roboshop-sg"
#  }

#  variable "tags_sg" {
#    description = "value of the Security Group"
#    type = map(string)
#    default     = {
#       project_name = "roboshop"
#       environment  = "dev"
#       "Name" = "roboshop-sg"
#     }
#  } 

#  variable "ssh_port" {
#    description = "SSH Port"
#    type = number
#    default     = 22
#  }
# variable "allowed_cidr_blocks" {
#     description = "CIDR Blocks"
#     type = list(string)  # ["apple","bananna","orange"]
#     default     = ["0.0.0.0/0"]
# }

# ############################
#  #ec2 varianbles
# ############################
# variable "instance_type" {
#   description = "Instance Type"
#   type = string
#   default     = "t2.micro"
# }

# variable "ami" {
#   description = "AMI ID"
#   type = string
#   default     = "ami-05b10e08d247fb927"
# }

# variable "key_name" {
#   description = "Key Name"
#   type = string
#   default     = "aws-class"
# }

# variable "tags_instance" {
#   description = "Tags for the Instance"
#   type = map(string)
 
# }

# variable "associate_public_ip_address" {
#   description = "Associate Public IP Address"
#   type = bool
#   default     = true
  
# }

# variable "instance_name" {
#   description = "name of instance"
#   type = map
# }


variable "sg_name" {
   type=string  
}

variable "sg_descritption" {
   type=string  
}

variable "ingress_rules"{
    type = list
} 

variable "app_sg_name" {
   type=string  
}

variable "app_ingress_rules" {
  type = list
  
}


variable "is_peering_required" {
  type = bool
}


variable "peering_env" {
   type=string  
}