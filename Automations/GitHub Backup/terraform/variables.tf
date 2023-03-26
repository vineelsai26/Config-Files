variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_region_az" {
  description = "AWS Region Availability Zone"
  type        = string
}

variable "github_token" {
  description = "GitHub Token"
  type        = string
}

variable "aws_bucket_name" {
  description = "AWS Bucket Name"
  type        = string
}

variable "aws_bucket_region" {
  description = "AWS Bucket Region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR Block"
  type        = string
}

variable "private_ip" {
  description = "Private IP for EC2"
  type        = string
}
