---
name: metadata-linting
description: Strict guidelines requiring AI agents to verify and maintain Blueprint Metadata passing status on lint tests.
---
# Metadata Linting Requirement

The Cloud Foundation Toolkit requires strict validation of Blueprint Metadata via `make docker_test_lint`.
For standard linting execution, this repository enforces the rule: `ENABLE_BPMETADATA=1`.

## Agent Instructions

When you analyze, modify, or troubleshoot CI failures related to `make docker_test_lint`, you **MUST** ensure that `ENABLE_BPMETADATA=1` is passed to the execution container in the `Makefile`.

Never skip metadata validation. If the metadata validator catches errors (such as missing inputs in `metadata.yaml`), you must correct the blueprint metadata to align with the Terraform inputs, rather than disabling the check.
