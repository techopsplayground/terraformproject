# providers.tf
terraform {
  required_version = "1.5.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12"
    }
  }
}

provider "aws" {
  region     = var.region
}

module "bastion_iam" {
  source       = "../../modules/iam/aws/instance_profile"
  prefix       = local.prefix
  s3_bucket_arn = aws_s3_bucket.s3.arn  # Assuming you already have an S3 bucket named `aws_s3_bucket.s3`
}

module "bastion_security_group" {
  source = "../../modules/networking/aws/security_group"

  prefix    = local.prefix
  vpc_id    = aws_vpc.main.id
  common_tags = local.common_tags
}

module "bastion" {
  source = "../../modules/compute/aws/ec2"

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.bastion-ssh.id]
  key_name               = "ssh-key"
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  availability_zone      = "${data.aws_region.current.name}a"
  common_tags            = local.common_tags
  instance_name          = "${local.prefix}-bastion-ec2"
  ssh_user               = "ec2-user"
  key_path               = var.keyPath
  setup_script           = "setup_script.sh"
  depends_on             = [aws_route.public_internet_access]
}
