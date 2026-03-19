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
  description = "The project ID."
  value       = var.project_id
}

output "app_ids" {
  description = "The configured app IDs"
  value       = module.multi_platform_app.app_ids
}

output "app_check_bundle" {
  description = "The app check bundle"
  value       = module.multi_platform_app.app_check_bundle
}

output "enabled_service_ids" {
  description = "The list of service IDs for which App Check enforcement is enabled."
  value       = module.app_check.enabled_service_ids
}

output "enabled_app_ids" {
  description = "A sorted list of all unique Firebase App IDs configured for App Check in this module."
  value       = module.app_check.enabled_app_ids
}
