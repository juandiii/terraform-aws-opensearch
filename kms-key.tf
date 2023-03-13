module "opensearch-kms-key" {
    source  = "app.terraform.io/lighting-solutions/kms-key/aws"
    version = "1.0.0"

    alias_name = var.base_name
    append_random_suffix = true
    description = "OS encryption KMS Key"

    key_type = "service"

    tags = var.tags

    service_key_info = {
        caller_account_ids = [data.aws_caller_identity.current.account_id]
        aws_service_names = ["es:${var.region}.amazonaws.com"]
    }
}