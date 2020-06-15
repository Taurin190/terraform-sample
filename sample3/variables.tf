variable "vpc_name" {
    default = "tf-sample3-vpc"
}

variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_availability_zones" {
  type = map(string)
  default = {
      a = "ap-northeast-1a"
      c = "ap-northeast-1c"
  }
}

variable "vpc_cidr" {
  default = "10.2.0.0/16"
}

variable "vpc_name_tag" {
  default = "terraform-import-vpc"
}

variable "subnet_cidr" {
  type = map(string)

  default = {
    public-a  = "10.2.10.0/24"
    public-c  = "10.2.20.0/24"
    private-a = "10.2.100.0/24"
    private-c = "10.2.200.0/24"
  }
}

variable "subnet_name_tag" {
  type = map(string)

  default = {
    public-a  = "sample3-public-subnet-a"
    public-c  = "sample3-public-subnet-c"
    private-a = "sample3-private-subnet-a"
    private-c = "sample3-private-subnet-c"
  }
}

variable "elb_name" {
  default = "sample3-lb"
}