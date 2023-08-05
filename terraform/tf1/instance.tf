resource "aws_instance" "tf-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "praneeth"
  vpc_security_group_ids = ["sg-0803c9e43432d0e1d"]
  tags = {
    Name    = "Tf-Instance"
    Project = "Terraform"
  }
}
