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
  description = "The project ID"
  value       = var.project_id
}

output "backend_id" {
  description = "The ID of the App Hosting backend"
  value       = google_firebase_app_hosting_backend.backend.backend_id
}

output "backend_name" {
  description = "The name of the App Hosting backend"
  value       = google_firebase_app_hosting_backend.backend.name
}

output "backend_uri" {
  description = "The primary URI to communicate with the backend."
  value       = google_firebase_app_hosting_backend.backend.uri
}

output "service_account_email" {
  description = "The email of the service account used by the App Hosting backend"
  value       = local.service_account
}

output "build_name" {
  description = "The name of the App Hosting build"
  value       = google_firebase_app_hosting_build.build.name
}

output "custom_domain_names" {
  description = "The names of the custom domains associated with the backend"
  value       = [for d in google_firebase_app_hosting_domain.custom_domain : d.name]
}

output "custom_domain_configs" {
  description = "Status and DNS configurations for the custom domains"
  value = {
    for domain_id, domain in google_firebase_app_hosting_domain.custom_domain :
    domain_id => domain.custom_domain_status
  }
}

output "default_domain_name" {
  description = "The name of the default domain associated with the backend"
  value       = length(google_firebase_app_hosting_default_domain.default) > 0 ? google_firebase_app_hosting_default_domain.default[0].name : null
}
