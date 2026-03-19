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

output "enabled_providers" {
  description = "List of enabled authentication providers."
  value = compact([
    var.auth_providers.google != null ? "google.com" : null,
    var.auth_providers.apple != null ? "apple.com" : null,
    var.auth_providers.facebook != null ? "facebook.com" : null,
    var.auth_providers.github != null ? "github.com" : null,
  ])
}
