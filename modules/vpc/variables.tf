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

variable "database_subnet_cidr" {
  description = "CIDR Block for the Subnet"
  type = list(string)
}

