# AWS Terraform module to create ECS cluster

Terraform module to create AWS ECS cluster


## Prerequisites
This module has a few dependencies:
* Terraform 0.12

## Examples
```hcl-terraform
module "ecs_cluster" {
  source = "git::https://github.com/arghul/terraform-aws-ecs-cluster.git?ref=master"

  name        = "ecs"
  namespace   = "arghul"
  environment = "prod"

  key_name   = "sshkey"
  subnet_ids = ["subnet-58f79f2e", "subnet-8ee658d6"]
  vpc_id     = "vpc-2424bb40"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | AMI ID to use. Defaults to Amazon ECS AMIs | `string` | `""` | no |
| ami\_owners | n/a | `list` | <pre>[<br>  "self",<br>  "amazon",<br>  "aws-marketplace"<br>]</pre> | no |
| attributes | Additional attributes | `list(string)` | `[]` | no |
| cpu\_credit\_specification | CPU credit specification | `string` | `"standard"` | no |
| delimiter | Label delimiter | `string` | `"-"` | no |
| desired\_capacity | Instance group desired capacity | `string` | `"1"` | no |
| detailed\_monitoring | Whether to enable detailed monitoring | `string` | `false` | no |
| ebs\_optimized | Whether instance is EBS optimized | `bool` | `false` | no |
| enable | Enable resource? | `bool` | `true` | no |
| enabled\_metrics | Enabled metrics | `list(string)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | n/a | yes |
| health\_check\_grace\_period | Health check grace period | `string` | `"600"` | no |
| instance\_type | Instance type | `string` | `"t2.micro"` | no |
| key\_name | SSH key name | `string` | n/a | yes |
| max\_size | Instance group maximum size | `string` | `"1"` | no |
| min\_size | Instance group minimum size | `string` | `"1"` | no |
| name | Service name | `string` | n/a | yes |
| namespace | Service namespace (eg: api, web, ops) | `string` | n/a | yes |
| root\_block\_device\_size | / block device size | `string` | `"8"` | no |
| root\_block\_device\_type | / block device type | `string` | `"gp2"` | no |
| short\_name | n/a | `bool` | `false` | no |
| spot\_enable | Enable spot instance | `bool` | `false` | no |
| spot\_instance\_interruption\_behavior | Spot instance interruption behavior | `string` | `"terminate"` | no |
| spot\_instance\_type | Spot instance type: persistent / one-time | `string` | `"persistent"` | no |
| spot\_max\_price | Spot instance bid max price | `string` | `"1"` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `""` | no |
| subnet\_ids | Subnet ids to start instances into | `list(string)` | n/a | yes |
| tags | Service tags | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | `"VPC Id"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | n/a |
| cluster\_name | n/a |
| cluster\_security\_group\_id | n/a |

