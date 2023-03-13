variable "region" {
    type = string
    description = "AWS Region"
    default = "us-east-1"
}

variable "vpc_id" {
    type = string
    description = "AWS VPC ID"
}

variable "base_name" {
    type = string
    description = "Domain Name"
}

variable "engine_version" {
    type = string
    description = "Engine version of opensearch"
    default = "OpenSearch_2.3"
}

variable "consumer_policy_actions" {
  type = map(list(string))
  description = "Consumer Policy Actions eg { ESRead = [es:ESHttpGet], ESWrite =[es:ESHttpPost] } )"
  default = {}
}

variable "azs" {
    type = set(string)
}

variable "zone_awareness_enabled" {
    type = bool
    default = false
}

variable "private_subnets_ids" {
    type = set(string)
}

variable "snapshot_schedule" {
    type = string
    default = ""
}

variable "cluster_config" {
  description = "ES Cluster configuration."
  type = object({
    instance_type = string
    instance_count = number
    dedicated_master_enabled = bool
    dedicated_master_count = number
    dedicated_master_type = string
  })

  default = {
    dedicated_master_enabled = false
    dedicated_master_count = 0
    dedicated_master_type = ""
    instance_count = 1
    instance_type = "t3.small.search"
  }
}

variable "advanced_options" {
  description = "ES Cluster configuration advanced options."
  type = object({
    rest_action_multi_allow_explicit_index = string
    indices_fielddata_cache_size           = string
    indices_query_bool_max_clause_count    = string
  })
  default = {
    indices_fielddata_cache_size = "80"
    indices_query_bool_max_clause_count = "1024"
    rest_action_multi_allow_explicit_index = "true"
  }
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "create_service_role" {
  type = bool
  description = "Service-Linked role to give Amazon ES permissions to access your vpc"
  default = false
}

variable "ebs_option" {
  type = object({
    volume_size = number
    volume_type = string
  })
  
  default = {
    volume_size = 45
    volume_type = "gp3"
  }
}

variable "snapshot_start" {
  type = number
  default = 0
}