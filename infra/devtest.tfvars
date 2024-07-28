webapp = {
  name       = "webapp"
  env        = "dev"
  sku        = "t2.micro"
  bucketname = "webapp-dev-bucket"

  # replicas 
  replicaMin = "1"
  replicaMax  = "2"
}