locals{
   resource_name = "${var.project_name}-${var.env}"  #
   azs = slice(data.aws_availability_zones.azs.names,0,2)
}

#azs=["us-east-1a","us-east-1b"] =2
#l=["a","b","c","d"]
#l[0:2]
