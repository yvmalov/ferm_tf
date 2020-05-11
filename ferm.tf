provider "aws" {
  // creds to vars form env: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION
}

resource "aws_instance" "frontend" {
  ami = "ami-0242ef423r3"
  instance_type = "t3.micro"
  count = 3
  tags = {
    Name = "Frontend. Ferm"
  }
}
