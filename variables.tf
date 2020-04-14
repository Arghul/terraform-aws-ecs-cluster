variable "enable" {
  description = "Enable resource?"
  type        = bool
  default     = true
}

variable "name" {
  description = "Service name"
  type        = string
}

variable "namespace" {
  description = "Service namespace (eg: api, web, ops)"
  type        = string
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  type        = string
}

variable "attributes" {
  description = "Additional attributes"
  type        = list(string)
  default     = []
}

variable "delimiter" {
  description = "Label delimiter"
  type        = string
  default     = "-"
}

variable "tags" {
  description = "Service tags"
  type        = map(string)
  default     = {}
}

variable "short_name" {
  type    = bool
  default = false
}

variable "vpc_id" {
  default = "VPC Id"
  type    = string
}

variable "ami_owners" {
  default = ["self", "amazon", "aws-marketplace"]
}

variable "ami_id" {
  description = "AMI ID to use. Defaults to Amazon ECS AMIs"
  type        = string
  default     = ""
}

variable "root_block_device_type" {
  description = "/ block device type"
  type        = string
  default     = "gp2"
}

variable "root_block_device_size" {
  description = "/ block device size"
  type        = string
  default     = "8"
}

variable "ebs_optimized" {
  description = "Whether instance is EBS optimized"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "spot_enable" {
  description = "Enable spot instance"
  type        = bool
  default     = false
}

variable "spot_max_price" {
  description = "Spot instance bid max price"
  type        = string
  default     = "1"
}

variable "spot_instance_interruption_behavior" {
  description = "Spot instance interruption behavior"
  type        = string
  default     = "terminate"
}

variable "spot_instance_type" {
  description = "Spot instance type: persistent / one-time"
  type        = string
  default     = "persistent"
}

variable "cpu_credit_specification" {
  description = "CPU credit specification"
  type        = string
  default     = "standard"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "detailed_monitoring" {
  description = "Whether to enable detailed monitoring"
  type        = string
  default     = false
}

variable "health_check_grace_period" {
  description = "Health check grace period"
  type        = string
  default     = "600"
}

variable "desired_capacity" {
  description = "Instance group desired capacity"
  type        = string
  default     = "1"
}

variable "min_size" {
  description = "Instance group minimum size"
  type        = string
  default     = "1"
}

variable "max_size" {
  description = "Instance group maximum size"
  type        = string
  default     = "1"
}

variable "enabled_metrics" {
  description = "Enabled metrics"
  type        = list(string)
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
}

variable "subnet_ids" {
  description = "Subnet ids to start instances into"
  type        = list(string)
}
