resource "aws_imagebuilder_infrastructure_configuration" "builder" {
  name                          = "builder"
  description                   = "for isunarabe image builder"
  instance_profile_name         = aws_iam_instance_profile.builder.name
  instance_types                = ["c5.large"]
  security_group_ids            = [aws_security_group.builder.id]
  subnet_id                     = aws_default_subnet.default_az1.id
  terminate_instance_on_failure = true
}

resource "aws_iam_instance_profile" "builder" {
  name = "builder"
  role = aws_iam_role.builder.name
}

resource "aws_iam_role" "builder" {
  name = "Ec2IsunarabeImageBuilder"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "sts:AssumeRole",
        Principal : {
          Service : "ec2.amazonaws.com",
        },
      },
    ],
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  inline_policy {
    name = "allow-download-tarball"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:GetObject*"]
          Effect   = "Allow"
          Resource = "arn:aws:s3:::isunarabe-images/*"
        },
      ]
    })
  }
}

data "aws_ami" "ubuntu_jammy" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
