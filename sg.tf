
resource "aws_instance" "web" {
  ami           = lookup(var.my_ami, var.my_region)
  instance_type = var.my_variable
  key_name = "${aws_key_pair.mykey1.key_name}"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.public1.id
  availability_zone = "us-east-1a"
  
  tags = {
        Name = "${local.stage}-ec2-sample"
  }
}

locals {
  ingress_rules = [{
    port = 22
    description = "ssh port for ingress rules"
  },
  
 {
   port = 80
   description = "http port for my ingress rules"
 }]

}
resource "aws_security_group" "allow_tls" {
name        = "allow_tls"
description = "Allow TLS inbound traffic"
vpc_id      = aws_vpc.vpcstack.id

dynamic "ingress"{
for_each = local.ingress_rules

  content{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   =ingress.value.port
    to_port     =ingress.value.port
    description =ingress.value.description
    protocol    ="tcp"
  }
  }
}

resource "aws_key_pair" "mykey1" {
  key_name   = "mykey1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDuXcP3ldP9PSwA/6eGCL4RM2+FoEa9SJX/Klcm1jYjxjD4UeuOCgppVJcwWXJaoTfs33piQz42TDAP/b50ly7L4moRR/rKimALJhtLIISdI3WhToEF3C92q031vqGcb6EUq33Jl7w8NYFuaQUVYe7zDI2HrKX7croznqJCKhlCF0CpScNtiSfIxID8A7NeGtdDUe2RZqGAOMg3+aCddt5YFCiGJ6rvT2LBDNLk2JJTRKq8d0oSVo7e3TZXcXU1/WXsN+M6ZgRM9Y7/RrHF4WyJaZoOQpdOJT/AwbQvkyC5PDQ1efWTv4vQxCUwMybDvHtMhc9J/7TKwQiixUCyftM04lhckksJzOSzZN9DMjh76xOpfY0r3uqY4O+JeXl89HRHog40V3zSOfPMEuRZcc7tQvWeS4CqnRLjDr+/MZ6Rwz8TzTCIyOLh9UqWHH7kJY4vixQJji4qFzPqny89wEZ349GmlfcRVSkVy0uyJ+CSpoIHf5uztRDrS7uFO3ogxuc= effio@Enoh-Yemi-Crown"

}


