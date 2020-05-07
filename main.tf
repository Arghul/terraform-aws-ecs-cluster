locals {
  name = var.short_name ? module.label.name : module.label.id
}

module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=master"
  namespace   = var.namespace
  stage       = var.stage
  environment = var.environment
  name        = var.name
  attributes  = var.attributes
  delimiter   = var.delimiter
  tags        = var.tags
}

module "instance_role" {
  source = "git::https://github.com/netf/terraform-aws-iam-role.git?ref=master"

  enabled = var.enable
  name   = "${local.name}-instance-role"
  allow_service = "ec2.amazonaws.com"
  policy_managed = [
    "service-role/AmazonEC2ContainerServiceforEC2Role",
    "AmazonSSMFullAccess" # TODO: reduce permissions (perhaps only for a particular namespace)
  ]
  tags = module.label.tags
}

module "service_role" {
  source = "git::https://github.com/netf/terraform-aws-iam-role.git?ref=master"

  enabled = var.enable
  name   = "${local.name}-service-role"
  allow_service = "ecs.amazonaws.com"
  policy_managed = [
    "service-role/AmazonEC2ContainerServiceRole"
  ]
  tags = merge(module.label.tags, {
    Name = "${local.name}-service-role"
  })
}

# ECS resources
resource "aws_ecs_cluster" "main" {
  count = var.enable ? 1 : 0

  name  = local.name
  tags = merge(module.label.tags, {
    Name = local.name
  })
}


# Security group resources
resource "aws_security_group" "main" {
  count = var.enable ? 1 : 0

  vpc_id = var.vpc_id
  name   = "${local.name}-sg"
  tags = merge(module.label.tags, {
    Name = "${local.name}-sg"
  })

}

resource "aws_security_group_rule" "egress" {
  count             = var.enable ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main[0].id
}

resource "aws_security_group_rule" "ingress" {
  count             = var.enable ? 1 : 0
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.main[0].id
}

data "template_cloudinit_config" "main" {
  count         = var.enable ? 1 : 0
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = <<EOF
#cloud-config

bootcmd:
  - mkdir -p /etc/ecs
  - echo "ECS_CLUSTER=${aws_ecs_cluster.main[0].name}" >> /etc/ecs/ecs.config
EOF
  }
}

data "aws_ami" "ecs_ami" {
  count       = var.enable && var.ami_id == "" ? 1 : 0
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "user_ami" {
  count       = var.enable && var.ami_id != "" ? 1 : 0
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}

resource "aws_launch_template" "main" {
  count = var.enable ? 1 : 0

  name_prefix   = "${local.name}-"
  ebs_optimized = var.ebs_optimized
  block_device_mappings {
    device_name = var.ami_id == "" ? join("", data.aws_ami.ecs_ami.*.root_device_name) : join("", data.aws_ami.user_ami.*.root_device_name)

    ebs {
      volume_type = var.root_block_device_type
      volume_size = var.root_block_device_size
    }
  }

  credit_specification {
    cpu_credits = var.cpu_credit_specification
  }

  disable_api_termination = false

  iam_instance_profile {
    name = module.instance_role.instance_profile_id
  }

  image_id = var.ami_id == "" ? join("", data.aws_ami.ecs_ami.*.image_id) : join("", data.aws_ami.user_ami.*.image_id)
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  vpc_security_group_ids               = [aws_security_group.main[0].id]
  user_data                            = base64encode(data.template_cloudinit_config.main[0].rendered)

  dynamic "instance_market_options" {
    for_each = var.spot_enable ? [1] : []
    content {
      market_type = "spot"
      spot_options {
        max_price                      = var.spot_max_price
        instance_interruption_behavior = var.spot_instance_interruption_behavior
        spot_instance_type             = var.spot_instance_type
      }
    }
  }

  monitoring {
    enabled = var.detailed_monitoring
  }

  tags = merge(module.label.tags, {
    Name = "${local.name}-lt"
  })
}

resource "aws_autoscaling_group" "main" {
  count = var.enable ? 1 : 0

  lifecycle {
    create_before_destroy = true
  }

  name = "${local.name}-asg"

  launch_template {
    id      = aws_launch_template.main[0].id
    version = "$Latest"
  }

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  termination_policies      = ["OldestLaunchConfiguration", "Default"]
  min_size                  = var.min_size
  max_size                  = var.max_size
  enabled_metrics           = var.enabled_metrics
  vpc_zone_identifier       = var.subnet_ids

  dynamic "tag" {
    for_each = merge(module.label.tags, {
      Name = "${local.name}-asg"
    })

    content {
      key                 = tag.key
      value               = tag.key == "Name" ? "${local.name}-instance" : tag.value
      propagate_at_launch = true
    }
  }
}

