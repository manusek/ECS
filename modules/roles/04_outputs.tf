output "execution_role_arn" {
  value = aws_iam_role.ecs_execution_role.arn
}

output "execution_role_id" {
  value = aws_iam_role.ecs_execution_role.id
}