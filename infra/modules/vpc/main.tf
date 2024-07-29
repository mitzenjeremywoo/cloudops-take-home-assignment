
resource "aws_vpc" "webapp_vpc" {
 cidr_block = var.vpc.vpc_cidr
 instance_tenancy = "default"
 enable_dns_hostnames = "true" 
 tags = {
  Name = "${var.vpc.name} vpc"
 }
}

# nsg 
resource "aws_security_group" "webapp_sg" {
 name = var.vpc.name
 description = "Allows SSH, HTTP"
 vpc_id = "${aws_vpc.webapp_vpc.id}"
 
 ingress {
  description = "SSH"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 
 ingress { 
  description = "HTTP"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

  ingress { 
  description = "HTTPS"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
 tags = {
  Name = "${var.vpc.name} http"
 }
}

# subnet 
resource "aws_subnet" "public" {
 vpc_id = aws_vpc.webapp_vpc.id
 cidr_block = var.vpc.public_cidr
 
 availability_zone = var.vpc.availability_zone
 map_public_ip_on_launch = "false"

 tags = {
  Name = "${var.vpc.name} public subnet"
 } 
}

# internet gateway
resource "aws_internet_gateway" "webapp_vpc_internet_gateway" {
 vpc_id = aws_vpc.webapp_vpc.id
 
 tags = { 
  Name = "${var.vpc.name} vpc internet gateway"
 }
}

# routes 
resource "aws_route_table" "webapp_route_table" {
 vpc_id = aws_vpc.webapp_vpc.id
 
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.webapp_vpc_internet_gateway.id}"
 }
 
 tags = {
  Name = "${var.vpc.name} route table"
 }
}

resource "aws_route_table_association" "rt_subnet_public" {
 subnet_id = "${aws_subnet.public.id}"
 route_table_id = "${aws_route_table.webapp_route_table.id}"
}
