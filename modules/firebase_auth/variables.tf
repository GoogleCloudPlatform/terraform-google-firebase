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
