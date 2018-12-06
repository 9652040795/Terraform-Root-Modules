#EC2 OUTPUTS
output "aws-key-pair" {
  value = "${aws_key_pair.key-pair-name.id}"
}
output "aws_instance" {
  value = "${aws_instance.cloudelligent-ec2-vpn.*.id}"
}
