# Firebase App Hosting Example

This example demonstrates how to deploy a Firebase App Hosting backend interconnected with a Firebase Web App.

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
| backend\_id | The ID of the App Hosting backend |
| backend\_name | The name of the App Hosting backend |
| backend\_uri | The primary URI to communicate with the backend. |
| build\_name | The name of the App Hosting build |
| custom\_domain\_configs | Status and DNS configurations for the custom domains |
| custom\_domain\_names | The names of the custom domains associated with the backend |
| default\_domain\_name | The name of the default domain associated with the backend |
| project\_id | The project ID. |
| service\_account\_email | The email of the service account used by the App Hosting backend |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
