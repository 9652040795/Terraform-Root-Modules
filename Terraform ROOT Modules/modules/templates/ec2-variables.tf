#EC2 VARIABLES
variable "ec2-ami-id" {
  default = ""
}
variable "instance-type" {
  default = ""
}

variable "single-subnet-id" {
  default = ""
}
variable "number-of-ec2-instance-required" {
  default = ""
}
variable "public-key-name-already-attached-in-key-pair-section" {
  default = ""
}
variable "attaching-public-key" {
  default = ""
}
variable "attaching-public-key-location" {
  default = ""
}
variable "user-data-bash-script" {
  default = ""
}
variable "ec2-instance-name" {
  default = ""
}




#EC2 Subnet ID's FOR LAUNCHING IN PUBLIC OR PRIVATE SUBNETS
variable "subnets-id" {
  type = "list"
  default = ["","",""]
}



#ELASTIC IP FOR EC2-Instance ASSOCIATION
#resource "aws_eip" "ec2-eip-1" {
#  vpc = "true"
#  depends_on = ["aws_internet_gateway.igw"]
#  network_interface = "${var.ec2-nic-1-id}"
#  instance = "i-04df1b7567f69fa92"
#  tags {
#    Name = "EC2-Elastic-IP-1-Gateway-1"
#  }
#}

#EC2 NIC-1 ID eth0
#variable "ec2-nic-1-id" {
#  default = "eni-06ff4d580aed824d6"
#}



#ELASTIC IP NO.2 FOR EC2-INSTANCE ASSOCIATION
#resource "aws_eip" "ec2-eip-2" {
#  vpc = "true"
#  depends_on = ["aws_internet_gateway.igw"]
#  network_interface = "${var.ec2-nic-2-id}"
#  instance = "i-01fa85ed8ef0ce793"
#  tags {
#    Name = "EC2-Elastic-IP-2-Gateway-2"
#  }

#}

#EC2 NIC-2 ID eth0
#variable "ec2-nic-2-id" {
#  default = "eni-0b4652913cc0c26e4"
#}