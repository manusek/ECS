resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-sg"
  vpc_id      = var.vpc_id 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     prefix_list_ids = [aws_vpc_endpoint.my_endpoint.prefix_list_id]
#   }

    tags = {
        Name    = "${var.project_name}-sg"
        Project = var.project_name
        Owner   = var.owner
    }
}
