resource "aws_instance" "Webserver" {
    ami = "ami-0a04068a95e6a1cde"
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.SG.id]

    user_data = <<-EOF
                #!/bin/bash
                sudo dnf update -y
                sudo dnf install httpd -y
                sudo systemctl enable httpd
                sudo systemctl start httpd
                #sudo echo "Hello, World" > /var/www/html/index.html
                #sudo sed /var/www/html > /var/www/html/index.html           
                EOF
    user_data_replace_on_change = true

    tags = {
        Name = "terraform-Webserver"
        Description = "This is a Webserver created with Terraform IaC Tool."
    }
}


resource "aws_security_group" "SG" {
  name        = "Terraform-Webserver-SG"
  
  ingress {
    from_port        = var.server_port
    to_port          = var.server_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
 }

