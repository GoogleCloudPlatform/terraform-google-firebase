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
  description = "Project ID"
  type        = string
}

variable "google_client_id" {
  description = "The Google Web Client ID"
  type        = string
  default     = "dummy-google-client-id"
}

variable "google_client_secret" {
  description = "The Google Web Client Secret"
  type        = string
  default     = "dummy-google-client-secret"
  sensitive   = true
}

variable "facebook_app_id" {
  description = "The Facebook App ID"
  type        = string
  default     = "12345678"
}

variable "facebook_app_secret" {
  description = "The Facebook App Secret"
  type        = string
  default     = "dummy-facebook-app-secret"
  sensitive   = true
}

variable "github_client_id" {
  description = "The GitHub OAuth Client ID"
  type        = string
  default     = "dummy-github-client-id"
}

variable "github_client_secret" {
  description = "The GitHub OAuth Secret"
  type        = string
  default     = "dummy-github-client-secret"
  sensitive   = true
}

variable "apple_service_id" {
  description = "The Apple Service ID"
  type        = string
  default     = "com.example.app"
}

variable "apple_team_id" {
  description = "The Apple Team ID"
  type        = string
  default     = "ABC123DEFG"
}

variable "apple_key_id" {
  description = "The Apple Private Key ID"
  type        = string
  default     = "KEY1234567"
}

variable "apple_client_secret" {
  description = "The content of the Apple Private Key file (.p8)"
  type        = string
  default     = "dummy-apple-client-secret"
  sensitive   = true
}
