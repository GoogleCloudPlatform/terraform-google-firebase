# Firestore Rules Example

This example demonstrates how to use the `firestore_rules` submodule to deploy Firestore security rules.

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
| location | The location of the Firestore database. | `string` | `"nam5"` | no |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_id | The ID of the Firestore database. |
| project\_id | The ID of the project. |
| release\_name | The name of the release. |
| ruleset\_name | The name of the ruleset. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
