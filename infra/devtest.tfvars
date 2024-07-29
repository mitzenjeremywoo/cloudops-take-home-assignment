webapp = {
  name                   = "webapp"
  env                    = "dev"
  tier                   = "WebServer"
  description            = "webapp dev environment"
  version_label          = ""
  sku                    = "t2.micro"
  bucketname             = "webapp-dev-bucket"
  wait_for_ready_timeout = "20m"

  enable_capacity_rebalancing    = true
  rolling_update_enabled         = true
  rolling_update_type            = "Health"
  updating_min_in_service        = 0
  enable_log_publication_control = true
  enable_stream_logs             = true

  # network 
  associate_public_ip_address = true
  application_subnets         = ["subnet-0bf87a977ddb585bc", "subnet-0babd975e40844acc"]

  # service 
  eb_service_role              = "arn:aws:iam::302234676760:role/service-role/aws-elasticbeanstalk-service-role"
  extended_ec2_policy_document = ""

  # replicas 
  replicaMin = "1"
  replicaMax = "2"

  env_vars = { env = "env1", version = "1" }
}

vpc = {
  name              = "webapp-vpc"
  vpc_cidr          = "10.0.0.0/16"
  public_cidr       = "10.0.0.0/26"
  availability_zone = "ap-southeast-2a"
}