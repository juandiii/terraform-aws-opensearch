resource "aws_security_group" "opensearch" {
    name = var.base_name
    description = "Security Group to allow trafic to OpenSearch"
  
    vpc_id = var.vpc_id

    tags = merge({
        Name = var.base_name
    }, var.tags)
}

resource "aws_security_group_rule" "opensearch_in_access" {
    type = "ingress"
    security_group_id = aws_security_group.opensearch.id
    from_port = 443
    to_port = 443
    protocol = "TCP"
    source_security_group_id = aws_security_group.opensearch.id
}

resource "aws_security_group_rule" "es_egress_https" {
    type = "egress"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.opensearch.id
}