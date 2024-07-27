resource "aws_elastic_beanstalk_application" "webapp" {
  name        = "${var.webapp.name}-${var.webapp.env}"
  description = "Take home test"
}

resource "aws_elastic_beanstalk_environment" "ebenvironment" {
  name                = var.webapp.env
  application         = aws_elastic_beanstalk_application.webapp.name
  solution_stack_name = "64bit Amazon Linux 2"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.webapp.sku
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "4"
  }
}