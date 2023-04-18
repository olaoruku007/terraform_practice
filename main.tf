resource "aws_instance" "Webserver" {
    ami = "ami-0a04068a95e6a1cde"
    instance_type = "t2.small"

    tags = {
        Name = "terraform-Webserver"
        Description = "This is a Webserver created with Terraform IaC Tool."
    }
}
