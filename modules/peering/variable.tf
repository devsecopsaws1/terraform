# Module for creating VPC Peering Connection
variable "requestor_vpc_id" {
  description = "The ID of the requestor VPC (the VPC initiating the peering)"
  type        = string
}

variable "peer_vpc_id" {
  description = "The ID of the peer VPC (the VPC being requested to peer)"
  type        = string
}

variable "requestor_cidr_block" {
  description = "CIDR block of the requestor VPC"
  type        = string
}

variable "peer_cidr_block" {
  description = "CIDR block of the peer VPC"
  type        = string
}

variable "auto_accept" {
  description = "Whether the peering connection is automatically accepted by the peer VPC"
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "The route table ID of the requestor VPC"
  type        = string
}

variable "dest_route_table_id" {
  description = "The route table ID of the requestor VPC"
  type        = string
}

variable "common_tags" {
  description = "Tags for the VPC"
  type = map(string)  #datatype of the variable and it is a key and value pair
  default = {
    "Billing" = "Platform"
  }
}

variable "env" {
   type=string  
}

variable "project_name" {
   type=string  
}

variable "is_peering_required" {
  type = bool
}
