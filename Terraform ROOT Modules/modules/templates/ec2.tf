#CREATING A NEW KEY PAIR AND EXPORTING OUR PUBLIC-KEY
resource "aws_key_pair" "key-pair-name" {
  key_name = "${var.attaching-public-key}"
  public_key = "${var.attaching-public-key-location}"
}



#Creating an EC2 instance, always mention the "Subnet ID"#
resource "aws_instance" "cloudelligent-ec2-vpn" {


  ami = "${var.ec2-ami-id}"
  instance_type = "${var.instance-type}"

#  Single Subnet
   #subnet_id = "${var.single-subnet-id}"

# Number of EC2-instances required.
  count = "${var.number-of-ec2-instance-required}"

  #EXISTING KEY PAIR OR CREATE ssh-keygen -f demo #it will give private & public keys, import public in aws
  #key_name = "${var.public-key-name-already-attached-in-key-pair-section}"

# EXPORTED PUBLIC-KEY
  key_name = "${var.attaching-public-key}"

# BASH SCRIPT
  user_data = "${var.user-data-bash-script}"

# MULTIPLE SUBNETS IDS
  subnet_id = "${element(var.subnets-id,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]

  tags {
    Name= "${var.ec2-instance-name}-${count.index+1}"
  }
}

