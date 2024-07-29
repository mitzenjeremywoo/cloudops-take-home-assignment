variable "webapp" {
  type = any
}

variable "partition" {
  type    = string
  default = "aws"
}

variable "vpc_id" {
  type    = string
}

variable "application_subnets" {
  type    = list(string)
  default = []
}