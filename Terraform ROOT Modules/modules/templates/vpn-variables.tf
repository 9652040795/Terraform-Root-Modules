#CUSTOMER GATEWAY
variable "aws-customer-gateway-static-public-ip" {
  default = ""
}
#CUSTOMER GATEWAY TAGS
variable "customer_gateway-name" {
  default = ""
}

#VPN CONNECTION NAME
variable "vpn-connection-name" {
  default = ""
}

#OFFICE CIDR
variable "office-cidr" {
  default = ""
}