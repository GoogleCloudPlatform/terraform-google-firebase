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

# Base Identity Platform Configuration
resource "google_identity_platform_config" "auth" {
  count    = var.enable_auth_management ? 1 : 0
  provider = google-beta
  project  = var.project_id

  sign_in {
    allow_duplicate_emails = var.auth_config.allow_duplicate_emails

    anonymous {
      enabled = var.auth_config.anonymous_enabled
    }

    email {
      enabled           = var.auth_config.email_enabled
      password_required = var.auth_config.email_password_required
    }

    phone_number {
      enabled            = var.auth_config.phone_enabled
      test_phone_numbers = var.auth_config.test_phone_numbers
    }
  }

  multi_tenant {
    allow_tenants = false
  }

  autodelete_anonymous_users = true
}

# Google Provider
resource "google_identity_platform_default_supported_idp_config" "google" {
  count         = var.auth_providers.google != null ? 1 : 0
  provider      = google-beta
  project       = var.project_id
  idp_id        = "google.com"
  enabled       = true
  client_id     = var.auth_providers.google.client_id
  client_secret = var.auth_providers.google.client_secret

  depends_on = [google_identity_platform_config.auth]
}

# Apple Provider
resource "google_identity_platform_default_supported_idp_config" "apple" {
  count     = var.auth_providers.apple != null ? 1 : 0
  provider  = google-beta
  project   = var.project_id
  idp_id    = "apple.com"
  enabled   = true
  client_id = var.auth_providers.apple.service_id
  client_secret = jsonencode({
    teamId     = var.auth_providers.apple.team_id
    keyId      = var.auth_providers.apple.key_id
    privateKey = var.auth_providers.apple.client_secret
  })

  depends_on = [google_identity_platform_config.auth]
}

# Facebook Provider
resource "google_identity_platform_default_supported_idp_config" "facebook" {
  count         = var.auth_providers.facebook != null ? 1 : 0
  provider      = google-beta
  project       = var.project_id
  idp_id        = "facebook.com"
  enabled       = true
  client_id     = var.auth_providers.facebook.app_id
  client_secret = var.auth_providers.facebook.app_secret

  depends_on = [google_identity_platform_config.auth]
}

# GitHub Provider
resource "google_identity_platform_default_supported_idp_config" "github" {
  count         = var.auth_providers.github != null ? 1 : 0
  provider      = google-beta
  project       = var.project_id
  idp_id        = "github.com"
  enabled       = true
  client_id     = var.auth_providers.github.client_id
  client_secret = var.auth_providers.github.client_secret

  depends_on = [google_identity_platform_config.auth]
}
