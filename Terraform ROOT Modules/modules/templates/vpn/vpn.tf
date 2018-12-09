resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "${var.aws-customer-gateway-static-public-ip}"
  type       = "ipsec.1"
  lifecycle {
    create_before_destroy = "true"
    prevent_destroy = "true"
  }
  tags {
    Name = "${var.customer_gateway-name}"
  }
}

resource "aws_vpn_connection" "vpn-connection" {
  vpn_gateway_id      = "${aws_vpn_gateway.vgw.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = true
  lifecycle {
    create_before_destroy = "true"
    prevent_destroy = "true"
  }
  tags {
    Name = "${var.vpn-connection-name}"
  }
}

resource "aws_vpn_connection_route" "office" {
  destination_cidr_block = "${var.office-cidr}"
  vpn_connection_id      = "${aws_vpn_connection.vpn-connection.id}"
  lifecycle {
    create_before_destroy = "true"
    prevent_destroy = "true"
  }

}




