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

  authorized_domains = distinct(concat(
    ["${var.project_id}.firebaseapp.com"],
    var.auth_config.authorized_domains != null ? var.auth_config.authorized_domains : []
  ))

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

  dynamic "multi_tenant" {
    for_each = [var.multi_tenant != null ? var.multi_tenant : { allow_tenant_creation = false, default_tenant_location = "" }]
    content {
      allow_tenants           = try(multi_tenant.value.allow_tenant_creation, false)
      default_tenant_location = try(multi_tenant.value.default_tenant_location, "")
    }
  }

  dynamic "sms_region_config" {
    for_each = var.auth_config.sms_region_config != null ? [var.auth_config.sms_region_config] : []
    content {
      dynamic "allow_by_default" {
        for_each = sms_region_config.value.allow_by_default != null ? [sms_region_config.value.allow_by_default] : []
        content {
          disallowed_regions = allow_by_default.value.disallowed_regions
        }
      }
      dynamic "allowlist_only" {
        for_each = sms_region_config.value.allowlist != null ? [sms_region_config.value.allowlist] : []
        content {
          allowed_regions = allowlist.value.allowed_regions
        }
      }
    }
  }

  dynamic "blocking_functions" {
    for_each = var.blocking_functions != null ? [var.blocking_functions] : []
    content {
      dynamic "triggers" {
        for_each = blocking_functions.value.triggers != null ? blocking_functions.value.triggers : []
        content {
          event_type   = triggers.value.event_type
          function_uri = triggers.value.function_uri
        }
      }
      dynamic "forward_inbound_credentials" {
        for_each = blocking_functions.value.forward_inbound_credentials != null ? [blocking_functions.value.forward_inbound_credentials] : []
        content {
          id_token      = forward_inbound_credentials.value.id_token
          access_token  = forward_inbound_credentials.value.access_token
          refresh_token = forward_inbound_credentials.value.refresh_token
        }
      }
    }
  }

  dynamic "quota" {
    for_each = var.quota != null ? [var.quota] : []
    content {
      dynamic "sign_up_quota_config" {
        for_each = quota.value.sign_up_quota_config != null ? [quota.value.sign_up_quota_config] : []
        content {
          quota          = sign_up_quota_config.value.quota
          start_time     = sign_up_quota_config.value.start_time
          quota_duration = sign_up_quota_config.value.quota_duration
        }
      }
    }
  }

  dynamic "mfa" {
    for_each = [var.mfa != null ? var.mfa : { state = "DISABLED", provider_configs = [] }]
    content {
      state = try(mfa.value.state, "DISABLED")
      dynamic "provider_configs" {
        for_each = try(mfa.value.provider_configs, [])
        content {
          state = try(provider_configs.value.state, "DISABLED")
          dynamic "totp_provider_config" {
            for_each = try([provider_configs.value.totp_provider_config], [])
            content {
              adjacent_intervals = try(totp_provider_config.value.adjacent_intervals, null)
            }
          }
        }
      }
    }
  }

  dynamic "monitoring" {
    for_each = [var.monitoring != null ? var.monitoring : { request_logging_enabled = false }]
    content {
      request_logging {
        enabled = try(monitoring.value.request_logging_enabled, false)
      }
    }
  }

  autodelete_anonymous_users = var.autodelete_anonymous_users

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
