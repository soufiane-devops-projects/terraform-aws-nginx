# Get the last ami ubuntu
data "aws_ami" "my_ubuntu_ami" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "mini-projet-ec2" {
  ami = data.aws_ami.my_ubuntu_ami.id
  instance_type = var.instance_type
  key_name = var.ssh_key
  availability_zone = var.AZ
  security_groups = [ "${var.sg_name}" ]
  tags = {
    Name = "${var.maintainer}-ec2"
  }
#Delete ebs volume on ec2 delete
  root_block_device {
    delete_on_termination = true
  }

  provisioner "local-exec" {
    # get IP from eip module (output)
    command = "echo PUBLIC IP: ${var.public_ip} >> IP_ec2.txt"
  }

  provisioner "remote-exec" {
    inline = [ 
        "sudo apt update -y",
        "sudo apt install nginx -y",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
     ]

     connection {
       type = "ssh"
       user = var.user
       private_key = file("../${var.ssh_key}.pem")
       host = self.public_ip
     }
  }
}