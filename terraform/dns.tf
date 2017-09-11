resource "aws_route53_record" "ext" {
  name    = "${var.role}"
  type    = "CNAME"
  ttl     = "60"
  zone_id = "${var.zone_id}"

  records = [
    "${aws_elb.ext.dns_name}",
  ]
}
