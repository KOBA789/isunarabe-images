resource "aws_imagebuilder_image_pipeline" "isu12q" {
  name                             = "isu12q"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.isu12q.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.builder.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.isu12q.arn
}

resource "aws_imagebuilder_image_recipe" "isu12q" {
  name         = "isu12q"
  parent_image = data.aws_ami.ubuntu_jammy.id
  version      = "1.0.0"

  block_device_mapping {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      volume_size           = 16
      volume_type           = "gp3"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.isu12q.arn
  }
}

resource "aws_imagebuilder_component" "isu12q" {
  name     = "isu12q"
  platform = "Linux"
  version  = "1.0.0"
  data     = file("./isu12q.yaml")
}

resource "aws_imagebuilder_distribution_configuration" "isu12q" {
  name = "isu12q"

  distribution {
    ami_distribution_configuration {
      name = "isu12q_v{{imagebuilder:buildVersion}}_{{imagebuilder:buildDate}}"
      ami_tags = {
        IsuconVersion = "isu12q"
      }
      launch_permission {
        user_groups = ["all"]
      }
    }
    region = data.aws_region.current.id
  }
}
