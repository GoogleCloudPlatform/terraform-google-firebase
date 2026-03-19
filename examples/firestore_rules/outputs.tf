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
  description = "The ID of the project."
  value       = var.project_id
}

output "database_id" {
  description = "The ID of the Firestore database."
  value       = google_firestore_database.database.name
}

output "ruleset_name" {
  description = "The name of the ruleset."
  value       = module.firestore_rules.ruleset_name
}

output "release_name" {
  description = "The name of the release."
  value       = module.firestore_rules.release_name
}
