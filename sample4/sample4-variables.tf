variable "vpc_name" {
    default = "tf-sample4-vpc"
}

variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_availability_zones" {
  default = {
    "ap-northeast-1" = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  }
}

variable "vpc_cidr" {
  default = "10.4.0.0/16"
}

variable "subnet_cidrs" {
  default = {
    "web" = ["10.4.0.0/24", "10.4.1.0/24", "10.4.2.0/24"],
    "app" = ["10.4.10.0/24", "10.4.11.0/24", "10.4.12.0/24"],
    "db" = ["10.4.20.0/24", "10.4.21.0/24", "10.4.22.0/24"]
  }
}

variable "subnet_name_tag" {
    default = {
        "web" = ["web-a", "web-c", "web-d"],
        "app" = ["app-a", "app-c", "app-d"],
        "db" = ["db-a", "db-c", "db-d"]
    }
}