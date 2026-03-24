# Firebase AI Logic Prompt Template

This module manages individual prompt templates for Firebase AI Logic.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_lock | Whether to create a production lock for the prompt template. | `bool` | `false` | no |
| location | The location for the prompt template. | `string` | `"global"` | no |
| project\_id | The project ID. | `string` | n/a | yes |
| template\_content | Prompt template content. Only one of `raw` or `gcs_object_source` should be provided. If both are provided, `raw` takes precedence. | <pre>object({<br>    raw = optional(string)<br>    gcs_object_source = optional(object({<br>      bucket = string<br>      name   = string<br>    }))<br>  })</pre> | n/a | yes |
| template\_id | The unique identifier for the prompt template. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| template\_id | The template identifier. |
| template\_name | The full resource name of the template. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
