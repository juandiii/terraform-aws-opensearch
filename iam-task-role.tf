resource "aws_iam_policy" "os" {
  name = "${var.base_name}-opensearch-${var.region}"
  policy = data.aws_iam_policy_document.os.json
}

data "aws_iam_policy_document" "os" {
  statement {
    sid = "es"
    effect = "Allow"

    actions = [
        "es:*"
    ]

    resources = [
        "arn:${data.aws_partition.active.partition}:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/${var.base_name}/*"
    ]
  }
}