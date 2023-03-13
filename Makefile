# cnf ?= .env
# include $(cnf)
# export $(shell sed 's/=.*//' $(cnf))

.PHONY: default help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

TF_ACTION?=plan

check-env: ## Check environment
ifndef ENV
	$(error Please set ENV=[staging|prod])
endif

terraform-create-workspace: check-env #Create workspace
	terraform workspace new $(ENV)

terraform-init: check-env ## Terraform Init
	terraform workspace select $(ENV) && \
	terraform init

terraform-action: check-env ## Terraform [action]
	AWS_DEFAULT_PROFILE=default && \
	terraform workspace select $(ENV) && \
	terraform $(TF_ACTION) \
	-var-file=./environments/$(ENV)/config.tfvars \
	-var-file=./environments/common.tfvars
