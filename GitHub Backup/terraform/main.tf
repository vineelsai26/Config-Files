# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "terraform-vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "terraform-internet-gateway"
  }
}

# create a custom route table
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }
}

# Create a subnet
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.aws_region_az
  tags = {
    Name = "terraform-subnet"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rtb.id
}

# Create a security group
resource "aws_security_group" "security_group" {
  name        = "terraform-security-group"
  description = "Allow SSH, HTTP, HTTPS traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-security-group"
  }
}

# Create a Network Interface
resource "aws_network_interface" "network_interface" {
  subnet_id       = aws_subnet.subnet.id
  description     = "terraform-network-interface"
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.security_group.id]
}

# Create an Elastic IP
resource "aws_eip" "eip" {
  vpc                       = true
  network_interface         = aws_network_interface.network_interface.id
  associate_with_private_ip = var.private_ip
  depends_on = [
    aws_network_interface.network_interface
  ]
}

# Create a EC2 instance
resource "aws_instance" "ec2-instance" {
  ami               = "ami-062df10d14676e201"
  instance_type     = "t3.2xlarge"
  availability_zone = var.aws_region_az
  key_name          = "AWS"

  root_block_device {
    volume_size = 400
  }

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.network_interface.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo fallocate -l 16G /swapfile
                sudo chmod 600 /swapfile
                sudo mkswap /swapfile
                sudo swapon /swapfile
                curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
                sudo apt install -y nodejs
                sudo apt install -y git git-lfs tar pigz
                sudo npm install -g yarn
                git clone https://github.com/vineelsai26/Automations
                cd 'Automations/GitHub Backup'
                git lfs install --skip-smudge
                export BASE_DIR='repos'
                export AUTH_TOKEN=${var.github_token}
                export AWS_ACCESS_KEY_ID=${var.aws_access_key}
                export AWS_SECRET_ACCESS_KEY=${var.aws_secret_key}
                export AWS_REGION=${var.aws_region}
                export AWS_BUCKET=${var.aws_bucket_name}
                yarn
                yarn build
                yarn start
              EOF

  tags = {
    Name = "terraform-ec2-instance-ubuntu"
  }
}
