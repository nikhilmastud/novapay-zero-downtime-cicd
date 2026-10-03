variable "aws_region" {
  type = string
  default = "ap-south-1"
}

variable "project_name" {
  type = string
  default = "novapay"
}

variable "container_port" {
  type = number
  default = 8080
}
