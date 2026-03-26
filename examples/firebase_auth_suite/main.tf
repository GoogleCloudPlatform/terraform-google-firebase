/**
 * Copyright 2026 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "auth_core" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_auth"
  version = "~> 0.1"

  project_id = var.project_id

  auth_config = {
    email_enabled          = true
    anonymous_enabled      = true
    allow_duplicate_emails = false
    authorized_domains     = ["example.com", "another-domain.com"]
    sms_region_config = {
      allow_by_default = {
        disallowed_regions = ["AC", "AD"]
      }
    }
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
