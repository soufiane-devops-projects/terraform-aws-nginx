provider "aws" {
  region = "eu-west-3"
  shared_credentials_files = ["../aws_credentials"]
}

# Create SG
module "sg" {
  source = "../modules/sg"
}

# Create volume EBS
module "ebs" {
  source = "../modules/ebs"
  disk_size = 5
}

# Create EIP
module "eip" {
  source = "../modules/eip"
}

# Create EC2
module "ec2" {
  source = "../modules/ec2"
  # surcharge
  instance_type = "t2.micro"
  public_ip = module.eip.output_eip
  sg_name = module.sg.output_sg_name
}

# Associate EIP to ec2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id = module.ec2.output_ec2_id
  allocation_id = module.eip.output_eip_id
}

# Associate ec2 instance to EBS volume
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id = module.ebs.output_id_volume
  instance_id = module.ec2.output_ec2_id
}