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
  description = "The project ID to deploy to."
  type        = string
}

variable "service_ids" {
  description = "The service IDs for which to enable App Check enforcement (e.g., identitytoolkit.googleapis.com)."
  type        = list(string)
  default     = []
}

variable "enforcement_mode" {
  description = "The enforcement mode for the service. Default is ENFORCED."
  type        = string
  default     = "ENFORCED"
}

variable "android_apps" {
  description = "List of Android apps to configure for App Check."
  type = list(object({
    app_id    = string
    token_ttl = optional(string)
  }))
  default = []
}

variable "apple_apps" {
  description = "List of Apple apps to configure for App Check."
  type = list(object({
    app_id     = string
    token_ttl  = optional(string)
    app_attest = optional(bool)
    device_check = optional(object({
      private_key = string
      key_id      = string
    }))
  }))
  default = []
}

variable "web_apps" {
  description = "List of Web apps to configure for App Check."
  type = list(object({
    app_id              = string
    site_key            = optional(string)
    recaptcha_v3_secret = optional(string)
    token_ttl           = optional(string)
  }))
  default = []
}

variable "debug_tokens" {
  description = "List of debug tokens to create for specific apps."
  type = list(object({
    app_id       = string
    display_name = optional(string, "Debug Token")
    token        = string
  }))
  default = []
}
