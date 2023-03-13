resource "aws_opensearch_domain" "os_domain" {
    domain_name = var.base_name
    engine_version = var.engine_version

    encrypt_at_rest {
      enabled = true
      kms_key_id = module.opensearch-kms-key.key_id
    }

    cluster_config {
      instance_type = var.cluster_config.instance_type
      instance_count = var.cluster_config.instance_count
      dedicated_master_count = var.cluster_config.dedicated_master_count
      dedicated_master_type = var.cluster_config.dedicated_master_type
      dedicated_master_enabled = var.cluster_config.dedicated_master_enabled
      zone_awareness_enabled = var.zone_awareness_enabled

      dynamic "zone_awareness_config" {
        for_each = var.zone_awareness_enabled ? [1] : []
        content {
          availability_zone_count = length(var.azs)
        }
      }
    }

    vpc_options {
      security_group_ids = [aws_security_group.opensearch.id]
      subnet_ids = var.private_subnets_ids
    }

    advanced_options = {
        "rest.action.multi.allow_explicit_index" = var.advanced_options.rest_action_multi_allow_explicit_index
        "indices.fielddata.cache.size"           = var.advanced_options.indices_fielddata_cache_size
        "indices.query.bool.max_clause_count"    = var.advanced_options.indices_query_bool_max_clause_count
    }

    ebs_options {
      ebs_enabled = true
      volume_size = var.ebs_option.volume_size
      volume_type = var.ebs_option.volume_type
    }

    snapshot_options {
      automated_snapshot_start_hour = var.snapshot_start
    }

    depends_on = [
      aws_iam_service_linked_role.es
    ]
}

resource "aws_iam_service_linked_role" "es" {
  count = var.create_service_role ? 1 : 0
  aws_service_name = "es.amazonaws.com"
  description = "Service Linked role to give Amazon ES permissions to access your vpc"
}