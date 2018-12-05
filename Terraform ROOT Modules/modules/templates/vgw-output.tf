#OUTPUT OF VGW
output "vgw" {
  value = "${aws_vpn_gateway.vgw.id}"
}