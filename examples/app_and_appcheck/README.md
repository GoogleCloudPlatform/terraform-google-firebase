# Firebase App and AppCheck Example

This example demonstrates how to configure Firebase App and AppCheck.

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
| app\_check\_bundle | The app check bundle |
| app\_ids | The configured app IDs |
| enabled\_app\_ids | A sorted list of all unique Firebase App IDs configured for App Check in this module. |
| enabled\_service\_ids | The list of service IDs for which App Check enforcement is enabled. |
| project\_id | The project ID. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
