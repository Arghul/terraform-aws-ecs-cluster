# AWS Terraform module to create ECS cluster

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_owners | n/a | `list` | <pre>[<br>  "self",<br>  "amazon",<br>  "aws-marketplace"<br>]</pre> | no |
| attributes | Additional attributes | `list(string)` | `[]` | no |
| cpu\_credit\_specification | n/a | `string` | `"standard"` | no |
| delimiter | Label delimiter | `string` | `"-"` | no |
| desired\_capacity | n/a | `string` | `"1"` | no |
| detailed\_monitoring | n/a | `bool` | `false` | no |
| enabled\_metrics | n/a | `list` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | n/a | yes |
| health\_check\_grace\_period | n/a | `string` | `"600"` | no |
| instance\_type | n/a | `string` | `"t2.micro"` | no |
| key\_name | n/a | `any` | n/a | yes |
| lookup\_latest\_ami | n/a | `bool` | `true` | no |
| max\_size | n/a | `string` | `"1"` | no |
| min\_size | n/a | `string` | `"1"` | no |
| name | Service name | `any` | n/a | yes |
| namespace | Service namespace (eg: api, web, ops) | `any` | n/a | yes |
| root\_block\_device\_size | n/a | `string` | `"8"` | no |
| root\_block\_device\_type | n/a | `string` | `"gp2"` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | n/a | yes |
| subnet\_ids | n/a | `list` | n/a | yes |
| tags | Service tags | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | `"VPC Id"` | no |

## Outputs

No output.

