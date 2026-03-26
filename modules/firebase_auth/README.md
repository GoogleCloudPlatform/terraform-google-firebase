# Firebase Authentication

This module manages Firebase Authentication (Identity Platform) configuration and social identity providers for a Google Cloud project.

## Usage

```hcl
module "firebase_auth" {
  source  = "GoogleCloudPlatform/firebase-auth/google"
  version = "~> 0.1"

  project_id = "my-project-id"

  auth_config = {
    email_enabled          = true
    anonymous_enabled      = true
    allow_duplicate_emails = false
  }

  auth_providers = {
    google = {
      client_id     = "your-client-id"
      client_secret = "your-client-secret"
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auth\_config | Core configuration for Firebase Identity Platform. | <pre>object({<br>    allow_duplicate_emails  = optional(bool, false)<br>    anonymous_enabled       = optional(bool, false)<br>    email_enabled           = optional(bool, false)<br>    email_password_required = optional(bool, true)<br>    phone_enabled           = optional(bool, false)<br>    test_phone_numbers      = optional(map(string), {})<br>    authorized_domains      = optional(list(string), ["localhost"])<br>    sms_region_config = optional(object({<br>      allow_by_default = optional(object({<br>        disallowed_regions = optional(list(string))<br>      }))<br>      allowlist = optional(object({<br>        allowed_regions = optional(list(string))<br>      }))<br>    }))<br>  })</pre> | `{}` | no |
| auth\_providers | Authentication provider configurations. | <pre>object({<br>    google = optional(object({<br>      client_id     = string<br>      client_secret = string<br>    }))<br>    apple = optional(object({<br>      service_id    = string<br>      team_id       = string<br>      key_id        = string<br>      client_secret = string<br>    }))<br>    facebook = optional(object({<br>      app_id     = string<br>      app_secret = string<br>    }))<br>    github = optional(object({<br>      client_id     = string<br>      client_secret = string<br>    }))<br>  })</pre> | `{}` | no |
| autodelete\_anonymous\_users | Whether to auto-delete anonymous users. | `bool` | `true` | no |
| blocking\_functions | Configuration related to blocking functions. | <pre>object({<br>    triggers = optional(list(object({<br>      event_type   = string<br>      function_uri = string<br>    })))<br>    forward_inbound_credentials = optional(object({<br>      id_token      = optional(bool)<br>      access_token  = optional(bool)<br>      refresh_token = optional(bool)<br>    }))<br>  })</pre> | `null` | no |
| enable\_auth\_management | Allows skipping config creation. | `bool` | `true` | no |
| mfa | Options related to Multi-Factor Authentication (MFA). | <pre>object({<br>    state = optional(string) # DISABLED, ENABLED, MANDATORY<br>    provider_configs = optional(list(object({<br>      state = optional(string)<br>      totp_provider_config = optional(object({<br>        adjacent_intervals = optional(number)<br>      }))<br>    })))<br>  })</pre> | `null` | no |
| monitoring | Configuration related to monitoring project activity. | <pre>object({<br>    request_logging_enabled = optional(bool)<br>  })</pre> | `null` | no |
| multi\_tenant | Configuration related to multi-tenant functionality. | <pre>object({<br>    allow_tenant_creation   = optional(bool)<br>    default_tenant_location = optional(string)<br>  })</pre> | `null` | no |
| project\_id | The GCP project ID to initialize Firebase Auth in. | `string` | n/a | yes |
| quota | Configuration related to quotas. | <pre>object({<br>    sign_up_quota_config = optional(object({<br>      quota          = optional(number)<br>      start_time     = optional(string)<br>      quota_duration = optional(string)<br>    }))<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| enabled\_providers | List of enabled authentication providers. |
| project\_id | The project ID. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
