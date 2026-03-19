# Firebase Multi-Platform Application Example

This example demonstrates how to use the `firebase_multi_platform_application` submodule to bootstrap a Firebase project with Web, Android, and Apple apps.

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
| project\_id | The GCP project ID to use for the example. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| android\_config | Android app configuration. |
| app\_ids | The created app IDs. |
| apple\_config | Apple app configuration. |
| project\_id | The project ID. |
| web\_config | Web app configuration. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
