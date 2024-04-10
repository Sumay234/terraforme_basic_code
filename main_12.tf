
/*


# --> Block
block_type {
    attribute_1 = value1
    attribute_2 = value2
}

resource "aws_instance" "example" {
    ami = "ami-00c0c"
    instance_type = "t2.micro"
    count = 3
    enabled = true

}

list = ["list1", "list2"]

# --> Maps
variable "example_map" {
    type = map
    default = {key1 = "name1", key2 = "name2", key3 = "name3"}
  
}

# To get the map result
locals.mymap["age"]


# Function
locals {
  name = "Sumay"
  fruits = ["apple", "banana", "mango"]
  message = "Hello ${upper(locals.name)}! I know you like ${join(",", locals.fruits)}"
}

# Resorce Dependency

resource "aws_instance" "name" {
  vpc_security_group_ids = aws_security_group.mysg.id
}

resource "aws_security_group" "mysg" {
  
}
*/