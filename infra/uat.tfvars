webapp = {
  name       = "webapp"
  env        = "uat"
  sku        = "t2.t2.xlarge"
  bucketname = "webapp-uat-bucket"

  # replicas 
  replicaMin = "1"
  replicaMax  = "2"

}