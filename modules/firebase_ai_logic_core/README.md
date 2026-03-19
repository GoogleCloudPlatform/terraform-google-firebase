# Firebase AI Logic Core Submodule

This module manages the project-wide global configuration for Firebase AI Logic.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_config | Configuration for which AI APIs to enable for Firebase AI Logic. | <pre>object({<br>    vertex_ai        = optional(bool, true)<br>    gemini_developer = optional(bool, false)<br>  })</pre> | `{}` | no |
| project\_id | The project ID to deploy to. | `string` | n/a | yes |
| telemetry\_mode | Telemetry mode for AI Logic (e.g., ALL, NONE). | `string` | `"NONE"` | no |
| telemetry\_sampling\_rate | Sampling rate for telemetry. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| config\_name | The name of the AI Logic configuration. |
| project\_id | The project ID. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
