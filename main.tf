# VPC Module
module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  aws_region          = var.aws_region
}

# Security Group Module
module "sg" {
  source       = "./modules/sg"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

# EC2 Module
module "ec2" {
  source               = "./modules/ec2"
  project_name         = var.project_name
  environment          = var.environment
  instance_type        = var.instance_type
  public_subnet_id     = module.vpc.public_subnet_id
  ec2_sg_id            = module.sg.ec2_sg_id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}

# RDS Module
module "rds" {
  source            = "./modules/rds"
  project_name      = var.project_name
  environment       = var.environment
  db_username       = var.db_username
  db_password       = var.db_password
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id  = module.vpc.public_subnet_id
  rds_sg_id         = module.sg.rds_sg_id
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment
resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
