output "cluster_name" {
  value = aws_ecs_cluster.main[0].name
}

output "cluster_id" {
  value = aws_ecs_cluster.main[0].id
}

output "cluster_security_group_id" {
  value = aws_security_group.main[0].id
}
