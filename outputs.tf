output "domiain_details" {
    description = "OpenSearch domain details"
    value = {
        arn = aws_opensearch_domain.os_domain.arn
        id = aws_opensearch_domain.os_domain.domain_id
        endpoint = aws_opensearch_domain.os_domain.endpoint
        kibana_endpoint = aws_opensearch_domain.os_domain.kibana_endpoint
    }
}

output "consumer_policies" {
  description = "OpenSearch Consumer Policies name and ARN map"
  value = {
    for name, policy in aws_iam_policy.consumers : name => policy.arn
  }
}

output "es_policy_arn" {
  value = aws_iam_policy.os.arn
}

output "asz" {
  value = length(var.azs)
}