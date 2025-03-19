locals {
  db_subnet_id = element(split(",", data.aws_ssm_parameter.database_subnet_ids.value),0)
}

#element(["a","b","c"],0) == "a"
#element(["a","b","c"],1) == "b"  element will take the value from the list based on the index
#split(",", "a,b,c") = ["a","b","c"]