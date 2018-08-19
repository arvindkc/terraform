provider "aws" {
	region="us-east-1"
}
variable "server_port" {
	description = "The port server will use for http requests"
	default = 22
}
resource "aws_instance" "fastai"{
	ami = "ami-c6ac1cbc"
	instance_type="p2.xlarge"
  key_name="kc-fast-ai"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
	tags {
		Name = "fastai-learn"
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"
	ingress {
		from_port = "${var.server_port}"
		to_port = "${var.server_port}"
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

output "fastai_ip" {
	value = "${aws_instance.fastai.public_ip}"
}
