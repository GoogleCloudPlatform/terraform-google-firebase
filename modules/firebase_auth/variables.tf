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

variable "project_id" {
  description = "The GCP project ID to initialize Firebase Auth in."
  type        = string
}

variable "enable_auth_management" {
  description = "Allows skipping config creation."
  type        = bool
  default     = true
}

variable "auth_config" {
  description = "Core configuration for Firebase Identity Platform."
  type = object({
    allow_duplicate_emails  = optional(bool, false)
    anonymous_enabled       = optional(bool, false)
    email_enabled           = optional(bool, false)
    email_password_required = optional(bool, true)
    phone_enabled           = optional(bool, false)
    test_phone_numbers      = optional(map(string), {})
    authorized_domains      = optional(list(string), ["localhost"])
    sms_region_config = optional(object({
      allow_by_default = optional(object({
        disallowed_regions = optional(list(string))
      }))
      allowlist = optional(object({
        allowed_regions = optional(list(string))
      }))
    }))
  })
  default = {}
}

variable "auth_providers" {
  description = "Authentication provider configurations."
  type = object({
    google = optional(object({
      client_id     = string
      client_secret = string
    }))
    apple = optional(object({
      service_id    = string
      team_id       = string
      key_id        = string
      client_secret = string
    }))
    facebook = optional(object({
      app_id     = string
      app_secret = string
    }))
    github = optional(object({
      client_id     = string
      client_secret = string
    }))
  })
  default = {}
}

variable "autodelete_anonymous_users" {
  description = "Whether to auto-delete anonymous users."
  type        = bool
  default     = true
}

variable "blocking_functions" {
  description = "Configuration related to blocking functions."
  type = object({
    triggers = optional(list(object({
      event_type   = string
      function_uri = string
    })))
    forward_inbound_credentials = optional(object({
      id_token      = optional(bool)
      access_token  = optional(bool)
      refresh_token = optional(bool)
    }))
  })
  default = null
}

variable "quota" {
  description = "Configuration related to quotas."
  type = object({
    sign_up_quota_config = optional(object({
      quota          = optional(number)
      start_time     = optional(string)
      quota_duration = optional(string)
    }))
  })
  default = null
}

variable "mfa" {
  description = "Options related to Multi-Factor Authentication (MFA)."
  type = object({
    state = optional(string) # DISABLED, ENABLED, MANDATORY
    provider_configs = optional(list(object({
      state = optional(string)
      totp_provider_config = optional(object({
        adjacent_intervals = optional(number)
      }))
    })))
  })
  default = null
}

variable "multi_tenant" {
  description = "Configuration related to multi-tenant functionality."
  type = object({
    allow_tenant_creation   = optional(bool)
    default_tenant_location = optional(string)
  })
  default = null
}

variable "monitoring" {
  description = "Configuration related to monitoring project activity."
  type = object({
    request_logging_enabled = optional(bool)
  })
  default = null
}
