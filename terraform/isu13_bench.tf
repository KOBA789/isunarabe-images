variable "isu13_bench_version" {
  type    = string
  default = "1.0.0"
}

resource "aws_imagebuilder_image_pipeline" "isu13_bench" {
  name                             = "isu13_bench"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.isu13_bench.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.builder.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.isu13_bench.arn
}

resource "aws_imagebuilder_image_recipe" "isu13_bench" {
  name         = "isu13_bench"
  parent_image = data.aws_ami.ubuntu_jammy.id
  version      = var.isu13_bench_version

  block_device_mapping {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      volume_size           = 16
      volume_type           = "gp3"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.isu13_bench.arn

    parameter {
      name  = "version"
      value = var.isu13_bench_version
    }
  }
}

resource "aws_imagebuilder_component" "isu13_bench" {
  name     = "isu13_bench"
  platform = "Linux"
  version  = "1.0.0"
  data     = file("./isu13_bench.yaml")
}

resource "aws_imagebuilder_distribution_configuration" "isu13_bench" {
  name = "isu13_bench"

  distribution {
    ami_distribution_configuration {
      name = "isu13_bench_{{imagebuilder:buildVersion}}_{{imagebuilder:buildDate}}"
      ami_tags = {
        Name             = "isu13_bench-v${var.isu13_bench_version}"
        IsunarabeProblem = "isu13_bench"
        IsunarabeVersion = var.isu13_bench_version
      }
      launch_permission {
        user_groups = ["all"]
      }
    }
    region = data.aws_region.current.id
  }
}
