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
  value       = module.app_hosting.project_id
}

output "backend_id" {
  description = "The ID of the App Hosting backend"
  value       = module.app_hosting.backend_id
}

output "backend_name" {
  description = "The name of the App Hosting backend"
  value       = module.app_hosting.backend_name
}

output "service_account_email" {
  description = "The email of the service account used by the App Hosting backend"
  value       = module.app_hosting.service_account_email
}

output "build_name" {
  description = "The name of the App Hosting build"
  value       = module.app_hosting.build_name
}
