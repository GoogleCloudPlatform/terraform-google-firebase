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
| auth\_config | Core configuration for Firebase Identity Platform. | <pre>object({<br>    allow_duplicate_emails  = optional(bool, false)<br>    anonymous_enabled       = optional(bool, false)<br>    email_enabled           = optional(bool, false)<br>    email_password_required = optional(bool, true)<br>    phone_enabled           = optional(bool, false)<br>    test_phone_numbers      = optional(map(string), {})<br>  })</pre> | `{}` | no |
| auth\_providers | Authentication provider configurations. | <pre>object({<br>    google = optional(object({<br>      client_id     = string<br>      client_secret = string<br>    }))<br>    apple = optional(object({<br>      service_id    = string<br>      team_id       = string<br>      key_id        = string<br>      client_secret = string<br>    }))<br>    facebook = optional(object({<br>      app_id     = string<br>      app_secret = string<br>    }))<br>    github = optional(object({<br>      client_id     = string<br>      client_secret = string<br>    }))<br>  })</pre> | `{}` | no |
| enable\_auth\_management | Allows skipping config creation. | `bool` | `true` | no |
| project\_id | The GCP project ID to initialize Firebase Auth in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| enabled\_providers | List of enabled authentication providers. |
| project\_id | The project ID. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
