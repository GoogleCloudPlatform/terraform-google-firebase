# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Please note that this file was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template).
# Please make sure to contribute relevant changes upstream!

# Make will use bash instead of sh
SHELL := /usr/bin/env bash

DOCKER_TAG_VERSION_DEVELOPER_TOOLS := 1
DOCKER_IMAGE_DEVELOPER_TOOLS := cft/developer-tools
REGISTRY_URL := gcr.io/cloud-foundation-cicd

export ENABLE_BPMETADATA := 1

# Enter docker container for local development
.PHONY: docker_run
docker_run:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/bin/bash

# Execute prepare tests within the docker container
.PHONY: docker_test_prepare
docker_test_prepare:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-e TF_VAR_org_id \
		-e TF_VAR_folder_id \
		-e TF_VAR_billing_account \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/execute_with_credentials.sh prepare_environment

# Clean up test environment within the docker container
.PHONY: docker_test_cleanup
docker_test_cleanup:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-e TF_VAR_org_id \
		-e TF_VAR_folder_id \
		-e TF_VAR_billing_account \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/execute_with_credentials.sh cleanup_environment

# Execute integration tests within the docker container
.PHONY: docker_test_integration
docker_test_integration:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		cft test run all

# Execute lint tests within the docker container
.PHONY: docker_test_lint
docker_test_lint:
	docker run --rm -it \
		-e ENABLE_BPMETADATA \
		-e EXCLUDE_LINT_DIRS \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/test_lint.sh
	docker run --rm -v "$(CURDIR):/workspace" -w /workspace node:18 npx markdownlint-cli2 "**/*.md" "#node_modules" "#**/.terraform/**"

# Format markdown files automatically
.PHONY: docker_format_md
docker_format_md:
	docker run --rm -v "$(CURDIR):/workspace" -w /workspace node:18 npx markdownlint-cli2 --fix "**/*.md" "#node_modules" "#**/.terraform/**"

# Generate documentation
.PHONY: docker_generate_docs
docker_generate_docs:
	docker run --rm -it \
		-e ENABLE_BPMETADATA \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/bin/bash -c 'source /usr/local/bin/task_helper_functions.sh && generate_docs display'

# Generate metadata
.PHONY: docker_generate_metadata_w_display
docker_generate_metadata:
	docker run --rm -it \
		-v "$(CURDIR)":/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/bin/bash -c 'source /usr/local/bin/task_helper_functions.sh && generate_metadata display'

# Alias for backwards compatibility
.PHONY: generate_docs
generate_docs: docker_generate_docs

# Run environment checks before testing
.PHONY: doctor
doctor:
	@test/doctor.sh
