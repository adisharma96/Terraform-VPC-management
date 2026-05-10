resource "aws_vpc" "my-vpc" {
   cidr_block = var.vpc_cidr
   enable_dns_hostname = true
   enable_dns_support = true

   tags = {
     Description = "VPC created using github workflows via Terraform"
   }

}

resource "aws_internet_gateway" "my-igw" {
   vpc_id = aws_vpc.my-vpc.id

   tags = {
      Name = "my-internet-gateway"
   }

}

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public_subnet_cidr 
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
   
    tags = {
      Name = "public-subnet"
    }

}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = "us-east-1b"
    
    tags = {
      Name = "private-subnet"
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id =  aws_vpc.my-vpc.id
    
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.my-igw.id
    }
 
    tags = {
      Name = "public-rt"
    }

}

resource "aws_route_table_association" "public-association" {
   subnet_id = aws_subnet.public-subnet.id
   route_table_id = aws_route_table.public-rt.id

}

resource "aws_route_table" "private-rt" {
   vpc_id = aws_vpc.my-vpc.id

   tags = {
      Name = "private-rt"
   }

}

resource "aws_route_table_association" "private-association" {
   subnet_id = aws_subnet.private-subnet.id
   route_table_id = aws_route_table.private-rt.id

}
