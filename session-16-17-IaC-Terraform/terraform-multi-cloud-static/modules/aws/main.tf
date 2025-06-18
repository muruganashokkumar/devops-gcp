
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-096e7821981a6b2a8"]

  tags = {
    Name = "ExampleAppServerInstance"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install default-jdk -y
    sudo apt install maven -y
    sudo apt install git -y
    git clone https://github.com/ramanujds/spring-boot
    cd spring-boot
    mvn clean package -DskipTests
    sudo java -jar target/spring-boot-aws.jar --server.port=80
  EOF
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}
