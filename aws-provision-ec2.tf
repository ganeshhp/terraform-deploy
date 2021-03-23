#variable "aws_access_key" {}
#variable "aws_secret_key" {}
#variable "private_key_path" {}
variable "key_name"  {
  default = "devops"
}
variable "ami_id" {
  default = "ami-03d64741867e7bb94"
}

provider "aws" {
#    access_key = "${var.aws_access_key}"
#    secret_key = "${var.aws_secret_key}"
    region     = "us-east-2"
}

data "aws_ami" "plusf-ami" {
  most_recent = true
  filter {
    name  = "name"
    values = ["plusf-*"]
  }
  owners = ["self"]
}

resource "aws_instance" "httpd" {
  ami       = "${data.aws_ami.plusf-ami.id}"
  instance_type = "t2.micro"
  key_name  = "${var.key_name}"

  connection {
    user     = "ec2-user"
    private_key = "${file(var.private_key_name)}"
  }
 }

