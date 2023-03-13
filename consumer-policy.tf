resource "aws_iam_policy" "consumers" {
  for_each = var.consumer_policy_actions
  name = "${var.base_name}-${each.key}-${var.region}"
  policy = data.aws_iam_policy_document.consumers[each.key].json
}

data "aws_iam_policy_document" "consumers" {
  for_each  = var.consumer_policy_actions
  policy_id = replace(each.key, "/[^a-zA-Z0-9]/", "")
  statement {
    effect  = "Allow"
    sid     = replace(each.key, "/[^a-zA-Z0-9]/", "")
    actions = each.value
    resources = [
      aws_opensearch_domain.os_domain.arn,
      "${aws_opensearch_domain.os_domain.arn}/*",
    ]
  }

  depends_on = [
    aws_opensearch_domain.os_domain
  ]

}