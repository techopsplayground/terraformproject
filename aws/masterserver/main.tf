terraform {
  required_version = ">= 1.0.0"
  backend "local" {}
}

provider "aws" {
  region = var.aws_region
}

module "ec2_instance" {
  source         = "../../modules/compute/aws/ec2"
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = var.key_name
  instance_name = "MyTerraformEC2"
  user_data     = file("${path.module}/masterserver.sh")
  my_ip         = var.my_ip  # Pass your IP
}
