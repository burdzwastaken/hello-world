resource "aws_iam_instance_profile" "default_profile" {
  name  = "${var.role}"
  role = "${aws_iam_role.default_role.name}"
}

resource "aws_iam_role" "default_role" {
  name = "${var.role}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
