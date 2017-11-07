/*
 * gateways outputs
 */

// Internet gateway
output "internet_gateway" {
  value = "${aws_internet_gateway.igw.id}"
}
// NAT gateway
output "nat_gateway_ids" {
  value = ["${aws_nat_gateway.nat.*.id}"]
}
// The list of EIPs associated with the subnets.
output "nat_ips" {
  value = ["${aws_eip.eip_nat.*.public_ip}"]
}
/*
// Corporate VPN gateway
output "corp_vpn_gateway" {
  value = "${aws_vpn_gateway.vgw_corp.id}"
}
// Corporate gateway
output "corp_gateway" {
  value = "${aws_customer_gateway.cgw_corp_vpn.}"
}
*/
