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

output "project_id" {
  description = "Project ID"
  value       = var.project_id
}

output "google_client_id" {
  description = "Google Client ID"
  value       = var.google_client_id
  sensitive   = true
}

output "facebook_app_id" {
  description = "Facebook App ID"
  value       = var.facebook_app_id
  sensitive   = true
}

output "github_client_id" {
  description = "GitHub Client ID"
  value       = var.github_client_id
  sensitive   = true
}

output "apple_service_id" {
  description = "Apple Service ID"
  value       = var.apple_service_id
  sensitive   = true
}
