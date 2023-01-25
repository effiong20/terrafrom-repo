//sample variable
variable "map_sample"{}

variable "list_user"{}

variable "enable_public_ip"{} 

variable "my_variable"{}

variable "my_ami"{
  type = map(string)
  default = {
    us-east-1 = "ami-0b0ea68c435eb488d"
    us-east-2 = "ami-0c77c2e3d6602e7a5"
    eu-west-1 = "ami-0f29c8402f8cce65c"
    eu-west-2 = "ami-07f293d45d00dff66"

  }
}

variable "my_region"{}

