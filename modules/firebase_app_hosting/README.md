# Firebase App Hosting

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
| [google_firebase_app_hosting_backend.backend](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/firebase_app_hosting_backend) | resource |
| [google_firebase_app_hosting_build.build](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/firebase_app_hosting_build) | resource |
| [google_firebase_app_hosting_default_domain.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/firebase_app_hosting_default_domain) | resource |
| [google_firebase_app_hosting_domain.custom_domain](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/firebase_app_hosting_domain) | resource |
| [google_firebase_app_hosting_traffic.traffic](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/firebase_app_hosting_traffic) | resource |
| [google_project_iam_member.app_hosting_sa_runner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_string.build_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_before_build](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the App Hosting backend | `string` | n/a | yes |
| <a name="input_backend_id"></a> [backend\_id](#input\_backend\_id) | The ID of the App Hosting backend | `string` | n/a | yes |
| <a name="input_web_app_id"></a> [web\_app\_id](#input\_web\_app\_id) | The ID of the Firebase Web App to associate with the backend | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the App Hosting backend | `string` | `null` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The service account used by the App Hosting backend | `string` | `null` | no |
| <a name="input_build"></a> [build](#input\_build) | The build configuration for the App Hosting backend | `object` | n/a | yes |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | A list of custom domains to associate with the backend | `list(string)` | `[]` | no |
| <a name="input_enable_default_domain"></a> [enable\_default_domain](#input\_enable\_default\_domain) | Whether to enable the default domain for the backend | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_id"></a> [backend\_id](#output\_backend\_id) | The ID of the App Hosting backend |
| <a name="output_backend_name"></a> [backend\_name](#output\_backend\_name) | The name of the App Hosting backend |
| <a name="output_backend_uri"></a> [backend\_uri](#output\_backend\_uri) | The primary URI to communicate with the backend |
| <a name="output_build_name"></a> [build\_name](#output\_build\_name) | The name of the App Hosting build |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The project ID |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | The email of the service account used by the App Hosting backend |
| <a name="output_custom_domain_names"></a> [custom\_domain\_names](#output\_custom\_domain\_names) | The names of the custom domains associated with the backend |
| <a name="output_custom_domain_configs"></a> [custom\_domain\_configs](#output\_custom\_domain\_configs) | Status and DNS configurations for the custom domains |
| <a name="output_default_domain_name"></a> [default\_domain\_name](#output\_default\_domain\_name) | The name of the default domain associated with the backend |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_id | The ID of the App Hosting backend | `string` | n/a | yes |
| build | The build configuration for the App Hosting backend | <pre>object({<br>    container_image = string<br>  })</pre> | n/a | yes |
| custom\_domains | A list of custom domains to associate with the backend | `list(string)` | `[]` | no |
| enable\_default\_domain | Whether to enable the default domain for the backend | `bool` | `true` | no |
| environment | The environment for the App Hosting backend | `string` | `null` | no |
| location | The location of the App Hosting backend | `string` | n/a | yes |
| project\_id | The project ID to deploy to | `string` | n/a | yes |
| service\_account | The service account used by the App Hosting backend | `string` | `null` | no |
| web\_app\_id | The ID of the Firebase Web App to associate with the backend | `string` | n/a | yes |

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
| project\_id | The project ID |
| service\_account\_email | The email of the service account used by the App Hosting backend |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
