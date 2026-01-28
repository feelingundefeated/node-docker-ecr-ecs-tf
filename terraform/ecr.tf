resource "aws_ecr_repository" "my_first_ecr_repo" {
  name                 = "my-first-ecr-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true # Safe for learning, risky for prod

  image_scanning_configuration {
    scan_on_push = true
  }
}