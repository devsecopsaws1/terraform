variable "env" {
   type=string  
}

variable "project_name" {
   type=string  
}

variable "sg_name" {
   type=string  
}

variable "sg_descritption" {
   type=string  
}

variable "vpc_id" {
   type=string  
}

variable "ingress_rules"{
    type = list
} 

variable "egress_rules"{
    type = list
    default = [
     {
        from_port = 0
        to_port = 0
        protocol = "-1" #all protocols
        cidr_blocks = ["0.0.0.0/0"]
     }
    ]
} 


variable "common_tags" {
  description = "Tags for the VPC"
  type = map(string)  #datatype of the variable and it is a key and value pair
  default = {
    "Billing" = "Platform"
  }
}