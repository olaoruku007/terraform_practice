data "aws_key_pair" "Dev_KP_OH" {
  key_name   = "Dev_KP_OH"
  
}

resource "aws_instance" "Webserver" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "Dev_KP_OH"
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
        Description = "This is a Webserver created with Terraform IaC Tool with the help of Samuel and Michael, my Boyz."
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

 resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG.id
}

