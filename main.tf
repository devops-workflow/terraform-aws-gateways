/**
 * AWS Network Gateways Terraform Module
 * =====================
 *
 * Usage:
 * ------
 *
 *     module "gateways" {
 *       source      = "../tf_gateways"
 *
 *       add variables
 *     }
**/

# TODO: Add gateways for Amazon resources: S3
#   setup routes in subnet

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }
  tags = "${ merge(
    var.tags,
    map("Name", var.namespaced ?
     format("%s-%s-igw", var.environment, var.name) :
     format("%s-igw", var.name) ),
    map("Environment", var.environment),
    map("Terraform", "true") )}"
}
/*
resource "aws_vpn_gateway" "vgw_corp" {
  vpc_id = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }
  tags {
    Name        = "${var.environment}-vgw-corp"
    Environment = "${var.environment}"
  }
}
*/
// Elastic IP resource
resource "aws_eip" "eip_nat" {
  count = "${var.num_of_azs}"
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  count         = "${var.num_of_azs}"
  subnet_id     = "${element(var.public_subnet_ids, count.index)}"
  allocation_id = "${element(aws_eip.eip_nat.*.id, count.index)}"
  depends_on    = ["aws_eip.eip_nat"]
  lifecycle {
    create_before_destroy = true
  }
}
/*
resource "aws_customer_gateway" "cgw_corp_vpn" {
  bgp_asn     = "12345"
  ip_address  = "x.x.x.x"
  type        = "ipsec.1"
  lifecycle {
    create_before_destroy = true
  }
  tags {
    Name        = "${var.environment}-cgw-corp-vpn"
    Environment = "${var.environment}"
  }
}
*/
