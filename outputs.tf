output "cluster_name" {
  value = [aws_ecs_cluster.main.*.name]
}

output "cluster_id" {
  value = [aws_ecs_cluster.main.*.id]
}

output "cluster_security_group_id" {
  value = [aws_security_group.main.*.id]
}
