#VPN-VGW
resource "aws_vpn_gateway" "vgw" {
  vpc_id = "${aws_vpc.vpc.id}"

  lifecycle {
    create_before_destroy = "true"
    prevent_destroy = "true"
  }
  tags {
    Name = "${var.aws-vgw-name}"
  }
}

############VPN-Route Propagations for Public Subnets###########
resource "aws_vpn_gateway_route_propagation" "vpn-public-subnets" {

  vpn_gateway_id = "${aws_vpn_gateway.vgw.id}"
  route_table_id = "${aws_route_table.public-routes.id}"

}

#######VPN-Route Propagations for Private Subnets############
resource "aws_vpn_gateway_route_propagation" "vpn-private-subnets" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  vpn_gateway_id = "${aws_vpn_gateway.vgw.id}"
  route_table_id = "${element(aws_route_table.private-routes.*.id,count.index)}"

}