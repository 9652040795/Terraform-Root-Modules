module "cloudelligent-dev" {
  source = "./modules/templates"
  ###VPC###
  instance-tenancy = "default"
  enable-dns-support = "true"
  vpc-name = "Cloudelligent-vpc"
  vpc-location = "London"
  region = "eu-west-2"
  internet-gateway-name = "Cloudelligent-igw"
  map_public_ip_on_launch = "true"
  public-subnets-name = "public-subnets"
  public-subnets-location = "London"
  public-subnet-routes-name = "public-subnet-routes"
  private-subnets-location-name = "London"
  total-nat-gateway-required = "3"
  eip-for-nat-gateway-name = "eip-nat-gateway"
  nat-gateway-name = "Cloudelligent-nat-gateway"
  eip-required = "3"
  private-route-cidr = "0.0.0.0/0"
  private-route-name = "private-route"
  vpc-cidr = "192.168.0.0/16"
  vpc-public-subnet-cidr = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
  vpc-private-subnet-cidr = ["192.168.4.0/24","192.168.5.0/24","192.168.6.0/24"]
  number-of-public-subnets-required = "3"
  number-of-private-subnets-required = "3"
  create-before-destroy-vpc = "true"
  prevent-destroy-vpc = "true"

  ###END-VPC


  ###VGW###
  aws-vgw-name = "Cloudelligent-vgw"
  ###END-VGW

  ###VPN###
  aws-customer-gateway-static-public-ip = "119.153.143.246"
  customer_gateway-name = "office-name"
  vpn-connection-name = "AWS-Virginia-vpn-link-office"
  office-cidr = "10.11.0.0/16"

  ###END-VPN

  ###EC2###
  ec2-ami-id = "ami-0274e11dced17bb5b"
  instance-type = "t2.micro"
#  single-subnet-id = ""
  number-of-ec2-instance-required = "3"
#  public-key-name-already-attached-in-key-pair-section = ""
  attaching-public-key = "power"
  attaching-public-key-location = "${file("./modules/templates/ec2/power.pub")}"
  user-data-bash-script = "${file("./modules/templates/ec2/httpd.sh")}"
  ec2-instance-name = "Centos"



   subnets-id = ["${module.cloudelligent-dev.public-subnet-ids}"]

#   subnets-id = ["${module.cloudelligent-dev.private-subnet-ids}"]


    #INCASE OF LAUNCHING IN SPECFIC SUBNETS
#   subnets-id = ["","","","","",""]
  ###END-EC2


  ###EC2-SECURITY GROUP###
  ec2-sg-name = "ec2-sg"

  ###SECURITY INBOUND GROUP RULES###
  #RULE-1-INBOUND-RULES
  rule-1-from-port= 80
  rule-1-protocol = "tcp"
  rule-1-to-port = 80
  rule-1-cidr_blocks = "0.0.0.0/0"

  #RULE-2-INBOUND-RULES

  rule-2-from-port = 443
  rule-2-protocol = "tcp"
  rule-2-to-port = 443
  rule-2-cidr_blocks = "0.0.0.0/0"

  #RULE-3-INBOUND-RULES
  rule-3-from-port = 22
  rule-3-protocol = "tcp"
  rule-3-to-port = 22
  rule-3-cidr_blocks = "119.153.149.158/32"


  #RULE-4-INBOUND-RULES
  rule-4-from-port = 10000
  rule-4-protocol =  "tcp"
  rule-4-to-port =   10000
  rule-4-cidr_blocks = "192.168.0.0/16"

  #RULE-5-INBOUND-RULES
  rule-5-from-port = 11000
  rule-5-protocol = "tcp"
  rule-5-to-port = 11000
  rule-5-cidr_blocks = "192.168.1.0/24"

  ###SECURITY GROUP OUTBOUND RULES###
  #RULE-1-OUTBOUND-RULES
  outbound-rule-1-from-port = 0
  outbound-rule-1-protocol = "-1"
  outbound-rule-1-to-port = 0
  outbound-rule-1-cidr_blocks = "0.0.0.0/0"

#NOTE: ONLY ALL PORTS WILL BE "" & CIDR BLOCK WILL IN COMMAS ""
  ###END-EC2-SG

}
