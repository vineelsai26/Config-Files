# Create a EC2 instance
resource "aws_instance" "ec2-instance" {
  ami               = "ami-062df10d14676e201"
  instance_type     = "t3.small"
  availability_zone = var.aws_region_az
  key_name          = "AWS"

  root_block_device {
    volume_size = 300
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt upgrade -y
                curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
                sudo apt install -y nodejs
                sudo apt install -y git
                sudo apt install -y npm
                npm install -g yarn
                git clone https://github.com/vineelsai26/Automations
                cd 'Automations/GitHub Backup'
                git lfs install --skip-smudge
                export AUTH_TOKEN=${var.github_token}
                export BASE_DIR=repos
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
