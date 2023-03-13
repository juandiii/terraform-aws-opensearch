data "aws_caller_identity" "current" {}

data "aws_partition" "active" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  base_name = lower(var.base_name)
  name_prefix = "${lower(var.base_name)}_"
  enable_snapshot = var.snapshot_schedule != "" ? true : false
}