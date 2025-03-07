output "vpc_id" {
  value = aws_vpc.roboshop_vpc.id # vpc_id = aws_vpc.roboshop_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_roboshop_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_roboshop_subnet[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public_roboshop_route_table.id
  
}

output "database_subnet_ids" {
  value = aws_subnet.database_roboshop_subnet[*].id
  
}
output "vpc_cider_block" {
  value = aws_vpc.roboshop_vpc.cidr_block
  
}