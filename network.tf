resource "aws_vpc" "roboshop_vpc" {
    cidr_block                           = var.cidr_block
    enable_dns_hostnames                 = var.enable_dns_hostnames
    enable_dns_support                   = var.enable_dns_support
    tags                                 = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}" # rorboshop-dev ${} === interpolation

                                           } )
}

resource "aws_internet_gateway" "roboshop_igw" {
    vpc_id                               = aws_vpc.roboshop_vpc.id
    tags                                 = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}" # rorboshop-dev ${} === interpolation

                                           } )
  
}

#2 public subnets public-1 -- 10.2.0.0/26, public-2 -- 10.2.0.64/26 === variable == [10.2.0.0/26,10.2.0.64/26] ==length(variable)=2

resource "aws_subnet" "public_roboshop_subnet" {
    count = length(var.public_subnet_cidr) #2 == 1st count.index = 0, 2nd count.index=1
    vpc_id                               = aws_vpc.roboshop_vpc.id
    cidr_block                           = var.public_subnet_cidr[count.index] # 32-26=6 = 2^(32-26)= 2^6 = 64 IPs
    availability_zone                    = local.azs[count.index] 
    map_public_ip_on_launch = true
    tags  = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}-public-${local.azs[count.index]}" # rorboshop-dev ${} === interpolation

                                           } )
}

resource "aws_subnet" "private_roboshop_subnet" {
    count = length(var.private_subnet_cidr) #2 == 1st count.index = 0, 2nd count.index=1
    vpc_id                               = aws_vpc.roboshop_vpc.id
    cidr_block                           = var.private_subnet_cidr[count.index] # 32-26=6 = 2^(32-26)= 2^6 = 64 IPs
    availability_zone                    = local.azs[count.index]
    tags  = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}-private-${local.azs[count.index]}" # rorboshop-dev ${} === interpolation

                                           } )
}



resource "aws_route_table" "public_roboshop_route_table" {
    vpc_id                               = aws_vpc.roboshop_vpc.id
    tags                                 = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}-public" # rorboshop-dev ${} === interpolation

                                           } )
}

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_roboshop_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.roboshop_igw.id

}

resource "aws_eip" "nat" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "roboshop-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_roboshop_subnet[0].id

  tags  = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}-public}" # rorboshop-dev ${} === interpolation

                                           } )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.roboshop_igw] #Nat resource of terraform will be created after internet gateway has been created.
}

#private subnet-- instance -- Private instance --- to internet --> NAT gateway -- staticIp(EIP)

resource "aws_route_table" "private_roboshop_route_table" {
    vpc_id                               = aws_vpc.roboshop_vpc.id
    tags                                 = merge(var.common_tags,
                                           {
                                            Name = "${var.project_name}-${var.env}-private" # rorboshop-dev ${} === interpolation

                                           } )
}

resource "aws_route" "private_route" {
  route_table_id            = aws_route_table.private_roboshop_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.roboshop-nat.id

}

resource "aws_route_table_association" "public_subnet" {
    count = length(var.public_subnet_cidr) #2
    subnet_id      = element(aws_subnet.public_roboshop_subnet[*].id, count.index) #element(list,index)
    route_table_id = aws_route_table.public_roboshop_route_table.id
}

resource "aws_route_table_association" "private_subnet" {
    count = length(var.private_subnet_cidr) #2
    subnet_id      = element(aws_subnet.private_roboshop_subnet[*].id, count.index) #element(list,index)
    route_table_id = aws_route_table.private_roboshop_route_table.id
}