# Firebase AI Logic Integrated Example

This example demonstrates how to set up Firebase AI Logic using a modular approach. It integrates with the `firebase_multi_platform_application` module and demonstrates creating multiple prompt templates.

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
| project\_id | The ID of the project to deploy to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ai\_logic\_config\_name | The name of the AI Logic configuration. |
| ai\_logic\_template\_names | The full resource names of the created prompt templates. |
| project\_id | The project ID. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
