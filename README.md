# terraform-google-firebase

terraform-google-firebase makes it easy to manage Firebase resources on Google Cloud Platform, following the Cloud Foundation Toolkit (CFT) standards.

This module consists of the following submodules:

- [firebase_multi_platform_application](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firebase_multi_platform_application)
- [firebase_auth](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firebase_auth)
- [firebase_app_check](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firebase_app_check)
- [firestore_rules](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firestore_rules)
- [firebase_ai_logic_core](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firebase_ai_logic_core)
- [firebase_ai_logic_prompt_template](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firebase_ai_logic_prompt_template)
- [firebase_app_hosting](https://github.com/GoogleCloudPlatform/terraform-google-firebase/tree/main/modules/firebase_app_hosting)

See more details in each module's README.

## Compatibility
This module is meant for use with Terraform 1.3+ and tested using Terraform 1.6+.
If you find incompatibilities using Terraform `>=1.13`, please open an issue.

## Root module

The root module has no configuration. Please switch to using one of the submodules.

## Requirements

### Installation Dependencies

- [Terraform](https://www.terraform.io/downloads.html) >= 1.3.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v5.0+
- [Terraform Provider Beta for GCP](https://github.com/terraform-providers/terraform-provider-google-beta) plugin v5.0+

### Configure a Service Account

In order to execute this module you must have a Service Account with the following:

#### Roles

- Firebase Admin: `roles/firebase.admin`
- Identity Toolkit Admin: `roles/identitytoolkit.admin` (Firebase Auth)
- Service Usage Admin: `roles/serviceusage.serviceUsageAdmin` (Enabling APIs)

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- `firebase.googleapis.com`
- `identitytoolkit.googleapis.com` (Firebase Auth)
- `firebaserules.googleapis.com` (Firestore Rules)
- `firebaseappcheck.googleapis.com` (App Check)
- `firebaseapphosting.googleapis.com` (App Hosting)

#### Service Account Credentials

You can pass the service account credentials into this module by setting the following environment variables:

* `GOOGLE_CREDENTIALS`
* `GOOGLE_CLOUD_KEYFILE_JSON`
* `GCLOUD_KEYFILE_JSON`

See more [details](https://www.terraform.io/docs/providers/google/provider_reference.html#configuration-reference).

## Provision Instructions

This module has no root configuration. A module with no root configuration cannot be used directly.

Copy and paste into your Terraform configuration, insert the variables, and run `terraform init`:

For Firebase Multi-Platform App:
```hcl
module "multi_platform_app" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_multi_platform_application"
  version = "~> 0.1"

  project_id = var.project_id

  apps = {
    web_app = {
      display_name = "Canonical Example Web App"
    }
    android_app = {
      package_name = "com.example.canonical"
    }
    apple_app = {
      bundle_id = "com.example.canonical"
    }
  }
}
```

or for Firebase Auth:

```hcl
module "auth_core" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_auth"
  version = "~> 0.1"

  project_id = var.project_id

  auth_config = {
    email_enabled          = true
    anonymous_enabled      = true
    allow_duplicate_emails = false
  }

  auth_providers = {
    google = {
      client_id     = var.google_client_id
      client_secret = var.google_client_secret
    }
    facebook = {
      app_id     = var.facebook_app_id
      app_secret = var.facebook_app_secret
    }
    github = {
      client_id     = var.github_client_id
      client_secret = var.github_client_secret
    }
    apple = {
      service_id    = var.apple_service_id
      team_id       = var.apple_team_id
      key_id        = var.apple_key_id
      client_secret = var.apple_client_secret
    }
  }
}
```

or for Firebase App Check:

```hcl
module "app_check" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_app_check"
  version = "~> 0.1"

  project_id = var.project_id

  service_ids = [
    "identitytoolkit.googleapis.com"
  ]

  android_apps = module.multi_platform_app.app_check_bundle.android
  apple_apps   = module.multi_platform_app.app_check_bundle.apple
  web_apps     = module.multi_platform_app.app_check_bundle.web
  debug_tokens = module.multi_platform_app.app_check_bundle.debug_tokens
}
```

or for Firebase App Hosting:

```hcl
module "app_hosting" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_app_hosting"
  version = "~> 0.1"

  project_id = var.project_id

  location   = "us-central1"
  backend_id = "example-backend"
  web_app_id = module.firebase_app.app_ids[0]

  build = {
    container_image = "us-docker.pkg.dev/cloudrun/container/hello"
  }
}
```

or for Firestore Rules:

```hcl
module "firestore_rules" {
  source        = "GoogleCloudPlatform/firebase/google//modules/firestore_rules"
  version       = "~> 0.1"

  project_id    = var.project_id
  database_id   = google_firestore_database.database.name
  rules_content = <<EOT
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
EOT
}
```

or for Firebase AI Logic Core:

```hcl
module "ai_logic_core" {
  source     = "GoogleCloudPlatform/firebase/google//modules/firebase_ai_logic_core"
  version    = "~> 0.1"

  project_id = var.project_id

  api_config = {
    vertex_ai        = true
    gemini_developer = true
  }
}
```

or for Firebase AI Logic (Prompt Template):

```hcl
module "ai_logic_template_direct" {
  source      = "GoogleCloudPlatform/firebase/google//modules/firebase_ai_logic_prompt_template"
  version     = "~> 0.1"

  project_id  = var.project_id
  template_id = "hello-world-direct"

  template_content = {
    raw = <<EOT
---
model: googleai/gemini-1.5-flash
---
Hello from a direct prompt template!
EOT
  }

  depends_on = [module.ai_logic_core]
}
```

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.
