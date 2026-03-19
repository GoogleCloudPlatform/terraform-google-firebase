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
 * See the License_ for the specific language governing permissions and
 * limitations under the License.
 */

output "template_id" {
  description = "The template identifier."
  value       = google_firebase_ai_logic_prompt_template.default.template_id
}

output "template_name" {
  description = "The full resource name of the template."
  value       = google_firebase_ai_logic_prompt_template.default.name
}
