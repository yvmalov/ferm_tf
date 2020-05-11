provider "aws" {}

resource "aws_instance" "webserver" {
  ami = "ami-0e342d72b12109f91" # Ubuntu 18.04 Server
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y apache2
echo "Web server started" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2
EOF
  tags = {
    Name = "Web Server by Terraform"
  }
}

resource "aws_security_group" "webserver" {
  name = "WebServer S.G."

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
