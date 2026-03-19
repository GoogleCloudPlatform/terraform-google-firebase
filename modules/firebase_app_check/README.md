# Firebase App Check Submodule

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
| android\_apps | List of Android apps to configure for App Check. | <pre>list(object({<br>    app_id    = string<br>    token_ttl = optional(string)<br>  }))</pre> | `[]` | no |
| apple\_apps | List of Apple apps to configure for App Check. | <pre>list(object({<br>    app_id     = string<br>    token_ttl  = optional(string)<br>    app_attest = optional(bool)<br>    device_check = optional(object({<br>      private_key = string<br>      key_id      = string<br>    }))<br>  }))</pre> | `[]` | no |
| debug\_tokens | List of debug tokens to create for specific apps. | <pre>list(object({<br>    app_id       = string<br>    display_name = optional(string, "Debug Token")<br>    token        = string<br>  }))</pre> | `[]` | no |
| enforcement\_mode | The enforcement mode for the service. Default is ENFORCED. | `string` | `"ENFORCED"` | no |
| project\_id | The project ID to deploy to. | `string` | n/a | yes |
| service\_ids | The service IDs for which to enable App Check enforcement (e.g., identitytoolkit.googleapis.com). | `list(string)` | `[]` | no |
| web\_apps | List of Web apps to configure for App Check. | <pre>list(object({<br>    app_id              = string<br>    site_key            = optional(string)<br>    recaptcha_v3_secret = optional(string)<br>    token_ttl           = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| enabled\_app\_ids | A sorted list of all unique Firebase App IDs configured for App Check in this module. |
| enabled\_service\_ids | The list of service IDs for which App Check enforcement is enabled. |
| project\_id | The project ID. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
