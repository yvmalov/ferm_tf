provider "aws" {}

resource "aws_instance" "webserver" {
  ami = "ami-0e342d72b12109f91" # Ubuntu 18.04 Server
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    app0 = "apache2",
    app1 = "wget",
  })
  tags = {
    Name = "Web Server by Terraform"
  }
}

resource "aws_security_group" "webserver" {
  name = "Dynamic WebServer S.G."

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
