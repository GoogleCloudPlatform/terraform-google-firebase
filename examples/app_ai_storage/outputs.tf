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

output "bucket_name" {
  description = "The name of the GCS bucket."
  value       = google_storage_bucket.prompts.name
}

output "object_name" {
  description = "The name of the GCS object containing the prompt."
  value       = google_storage_bucket_object.prompt_file.name
}

output "template_id" {
  description = "The prompt template ID created."
  value       = module.ai_logic_template.template_id
}
