# Firebase App Hosting Submodule

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0, < 8.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.0, < 8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [terraform_data.placeholder](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_placeholder"></a> [placeholder](#output\_placeholder) | Placeholder output |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The project ID |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_id | The ID of the App Hosting backend | `string` | n/a | yes |
| build | The build configuration for the App Hosting backend | <pre>object({<br>    container_image = string<br>  })</pre> | n/a | yes |
| location | The location of the App Hosting backend | `string` | n/a | yes |
| project\_id | The project ID to deploy to | `string` | n/a | yes |
| web\_app\_id | The ID of the Firebase Web App to associate with the backend | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| backend\_id | The ID of the App Hosting backend |
| backend\_name | The name of the App Hosting backend |
| build\_name | The name of the App Hosting build |
| project\_id | The project ID |
| service\_account\_email | The email of the service account used by the App Hosting backend |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
