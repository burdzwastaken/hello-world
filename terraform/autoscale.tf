resource "aws_launch_configuration" "launch_configuration" {
  name_prefix   = "${var.role}-${var.environment}-"
  image_id      = "${var.ami.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_public_key_name}"

  security_groups = [
    "${aws_security_group.main.id}",
  ]
}

resource "aws_autoscaling_group" "autoscaling_group" {
  vpc_zone_identifier = [
    "${split(",", var.private_subnets)}",
  ]

  name                      = "${var.role}-${var.environment}"
  max_size                  = "${var.cluster_size}"
  min_size                  = "${var.cluster_size}"
  desired_capacity          = "${var.cluster_size}"
  health_check_type         = "ELB"
  health_check_grace_period = 300
  launch_configuration      = "${aws_launch_configuration.launch_configuration.name}"

  load_balancers = [
    "${aws_elb.ext.name}",
  ]

  tag {
    key                 = "Name"
    value               = "${var.role}-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ENV"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

