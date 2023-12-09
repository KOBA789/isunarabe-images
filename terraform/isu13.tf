variable "isu13_version" {
  type    = string
  default = "1.0.0"
}

resource "aws_imagebuilder_image_pipeline" "isu13" {
  name                             = "isu13"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.isu13.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.builder.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.isu13.arn
}

resource "aws_imagebuilder_image_recipe" "isu13" {
  name         = "isu13"
  parent_image = data.aws_ami.ubuntu_jammy.id
  version      = var.isu13_version

  block_device_mapping {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      volume_size           = 16
      volume_type           = "gp3"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.isu13.arn

    parameter {
      name  = "version"
      value = var.isu13_version
    }
  }
}

resource "aws_imagebuilder_component" "isu13" {
  name     = "isu13"
  platform = "Linux"
  version  = "1.0.0"
  data     = file("./isu13.yaml")
}

resource "aws_imagebuilder_distribution_configuration" "isu13" {
  name = "isu13"

  distribution {
    ami_distribution_configuration {
      name = "isu13_{{imagebuilder:buildVersion}}_{{imagebuilder:buildDate}}"
      ami_tags = {
        Name             = "isu13-v${var.isu13_version}"
        IsunarabeProblem = "isu13"
        IsunarabeVersion = var.isu13_version
      }
      launch_permission {
        user_groups = ["all"]
      }
    }
    region = data.aws_region.current.id
  }
}
