output "vpcid" {
value = aws_vpc.vpcstack.id
}
//sampls output
output "instance-ip"{
    value = aws_instance.web.public_ip
}

output "subnet_id"{
    value= aws_subnet.public1.id
}

output "subnet_cidr_block"{
    value = aws_subnet.public2.cidr_block
}