resource "aws_security_group" "main" {
  name        = "${var.role}-${var.environment}"
  description = "${var.role}-${var.environment}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "ext_elb" {
  name        = "${var.role}-ext_elb_${var.environment}"
  description = "${var.role}-ext_elb_${var.environment}"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port = "${var.instance_port}"
    to_port   = "${var.instance_port}"
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.main.id}",
    ]
  }
}

resource "aws_security_group" "ext_elb_http" {
  name        = "${var.role}-ext_elb_http_${var.environment}"
  description = "${var.role}-ext_elb_http_${var.environment}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
}
