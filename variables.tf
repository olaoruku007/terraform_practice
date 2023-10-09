variable "region" {
    description = "The region the resources will be launched"
    type = string
    default = "us-east-2"
}

variable "ami" {
    description = " The ami to be used by the instance"
    type = list(string)
    default = ["ami-0a04068a95e6a1cde", "ami-0dbe8f888bb358007", "ami-0e534f3e5321ed9ed"]
}

variable "instance_type" {
    description = "The instance type to be used"
    type = string
    default = "t2.small"
}

variable "server_port" {
    description = " The port the server will use for http request"
    type = number
    default = 80
}