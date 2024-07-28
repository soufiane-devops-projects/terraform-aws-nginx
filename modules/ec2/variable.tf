variable "maintainer" {
  type = string
  default = "Soufiane"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ssh_key" {
  type = string
  default = "devops"
}

variable "sg_name" {
  type = string
#   Sera surchargé lors de l'appel au module sg
  default = "NULL"
}

variable "public_ip" {
    type = string
#   Sera surchargé lors de l'appel au module eip
    default = "NULL"
}

variable "AZ" {
  type = string
  default = "eu-west-3a"
}

variable "user" {
  type = string
  default = "ubuntu"
}