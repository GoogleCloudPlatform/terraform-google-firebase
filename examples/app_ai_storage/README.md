# Firebase App AI Storage Example

This example demonstrates how to set up Firebase App, AI, and Storage integrations.

## Run Terraform

Create resources with terraform:

```bash
terraform init
terraform plan
terraform apply
```

To remove all resources created by terraform:

```bash
terraform destroy
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| app\_ids | The configured app IDs |
| bucket\_name | The name of the GCS bucket. |
| object\_name | The name of the GCS object containing the prompt. |
| project\_id | The project ID. |
| template\_id | The prompt template ID created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
