terraform {
  required_version = "~> 0.12.1"
}

provider "aws" {
  region = var.region
}


module "ecs_cluster" {
  source  = "../"

  name = "ecs"
  namespace = "arghul"
  environment = "prod"

  key_name = "netf"
  subnet_ids = [ "subnet-58f79f2e", "subnet-8ee658d6" ]
  vpc_id = "vpc-2424bb40"

}
