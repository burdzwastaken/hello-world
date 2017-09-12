resource "aws_elb" "ext" {
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 2
    interval            = 15
    target              = "TCP:${var.instance_port}"
    timeout             = 3
    unhealthy_threshold = 2
  }

  internal = false

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  name = "${var.role}-${var.environment}-ext"

  security_groups = [
    "${aws_security_group.ext_elb.id}",
    "${aws_security_group.ext_elb_http.id}",
  ]

  availability_zones = ["${var.asg_azs}"]
}
