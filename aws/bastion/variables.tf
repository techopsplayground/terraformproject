# variables.tf
variable "region" {
  type    = string
  default = "us-west-1"
}

variable "prefix" {
  default = "main"
}

variable "project" {
  default = "terraformproject"
}

variable "contact" {
  default = "mohit.itsector@gmail.com"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_list" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_type" {
  description = "The type of EC2 instance for the bastion host"
  type        = string
  default = "t2.micro"
}

variable "keyPath" {
  description = "Path to the SSH private key"
  type        = string
}