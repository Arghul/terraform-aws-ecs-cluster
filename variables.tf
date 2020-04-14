variable "enable" {
  type    = bool
  default = true
}

variable "name" {
  description = "Service name"
}

variable "namespace" {
  description = "Service namespace (eg: api, web, ops)"
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  type        = string
  default = ""
}

variable "environment" {
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  type        = string
}

variable "attributes" {
  description = "Additional attributes"
  type = list(string)
  default = []
}

variable "delimiter" {
  description = "Label delimiter"
  type = string
  default = "-"
}

variable "tags" {
  description = "Service tags"
  type = map(string)
  default = {}
}

variable "short_name" {
  type    = bool
  default = false
}

variable "vpc_id" {
  default = "VPC Id"
  type = string
}

variable "ami_owners" {
  default = ["self", "amazon", "aws-marketplace"]
}

variable "ami_id" {
  description = "AMI ID to use. Defaults to Amazon ECS AMIs"
  type        = string
  default     = ""
}

variable "lookup_latest_ami" {
  default = true
}

variable "root_block_device_type" {
  default = "gp2"
}

variable "root_block_device_size" {
  default = "8"
}

variable "ebs_optimized" {
  description = ""
  type = bool
  default = false
}

variable "instance_type" {
  default = "t2.micro"
}

variable "spot_enable" {
  description = ""
  type = bool
  default = false
}

variable "spot_max_price" {
  description = ""
  type = string
  default = "1"
}

variable "spot_instance_interruption_behavior" {
  description = ""
  type = string
  default = "terminate"
}

variable "spot_instance_type" {
  description = ""
  type = string
  default = "persistent"
}

variable "cpu_credit_specification" {
  default = "standard"
}

variable "key_name" {
  description = ""
  type = string
}

variable "detailed_monitoring" {
  default = false
}

variable "health_check_grace_period" {
  default = "600"
}

variable "desired_capacity" {
  default = "1"
}

variable "min_size" {
  default = "1"
}

variable "max_size" {
  default = "1"
}

variable "enabled_metrics" {
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  type = list
}

variable "subnet_ids" {
  type = list
}
