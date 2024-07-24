module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "myapp-ECR"
  version = "2.2.1"

  repository_read_write_access_arns = ["arn:aws:iam::992382761454:role/terraform"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

   tags = merge(
    var.tags,
    {
      Name = format("%s-ECR", var.name)
    },
  )
}
