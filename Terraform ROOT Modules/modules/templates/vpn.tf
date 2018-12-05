resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "${var.aws-customer-gateway-static-public-ip}"
  type       = "ipsec.1"
  tags {
    Name = "${var.customer_gateway-name}"
  }
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = "${aws_vpc.my-vpc.id}"
  tags {
    Name = "${var.aws-vgw-name}"
  }
}

resource "aws_vpn_connection" "vpn-connection" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = true
  tags {
    Name = "${var.vpn-connection-name}"
  }
}

resource "aws_vpn_connection_route" "office" {
  destination_cidr_block = "${var.office-cidr}"
  vpn_connection_id      = "${aws_vpn_connection.vpn-connection.id}"

}

############Route Propagations for Public Subnets###########
resource "aws_vpn_gateway_route_propagation" "vpn-public-subnets" {

  vpn_gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  route_table_id = "${aws_route_table.public-routes.id}"

}

#######Route Propagations for Private Subnets############
resource "aws_vpn_gateway_route_propagation" "vpn-private-subnets" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  route_table_id = "${element(aws_route_table.private-routes.*.id,count.index)}"

}
