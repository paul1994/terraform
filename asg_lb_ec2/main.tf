provider "aws" {
  region = "us-west-2"
}
variable "server_port" {
  description = "the port that the webserver will listen on"
  default = 8080
}
# resource "aws_elb" "eample" {
#   name          = "terraform-asg-example"
# }
# resource "aws_launch_configuration" "example" {
#   image_id      = "ami-79873901"
#   instance_type = "t2.micro"
#   security_groups = ["sg-359f744a","sg-18df3467"]
#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World This is a Test" > index.html
#               nohup busybox httpd - f -p ${var.server_port} &
#               EOF
#   lifecycle {
#     create_before_destroy = true
#   }
# }
resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-79873901"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-359f744a","sg-18df3467"]
  subnet_id     = "subnet-26e5e56e"
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World This is a Test" > index.html
              nohup busybox httpd - f -p ${var.server_port} &
              EOF
tags {
  Name = "Terraform-example"
  Application = "test"
  OS          = "Ubuntu 16 svr"
 }
}
output "public_ip" {
  value = "${aws_instance.example.*.public_ip}"
}
