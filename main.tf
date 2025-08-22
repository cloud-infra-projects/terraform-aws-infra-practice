# 최신 Amazon Linux 2023 AMI (x86_64) 조회
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]  # 공식 Amazon 이미지

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type

  tags = {
    Name = "terraform-first-ec2"
  }
}
