resource "aws_instance" "Webserver" {
    ami = "ami-0a04068a95e6a1cde"
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.SG.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
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
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    
  }

}

