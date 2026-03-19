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

# Fetch content from GCS if gcs_source is provided
data "google_storage_bucket_object_content" "sourced" {
  count    = var.template_content.gcs_object_source != null ? 1 : 0
  provider = google-beta
  bucket   = var.template_content.gcs_object_source.bucket
  name     = var.template_content.gcs_object_source.name
}

resource "google_firebase_ai_logic_prompt_template" "default" {
  provider        = google-beta
  project         = var.project_id
  location        = var.location
  template_id     = var.template_id
  template_string = var.template_content.raw != null ? var.template_content.raw : (var.template_content.gcs_object_source != null ? data.google_storage_bucket_object_content.sourced[0].content : null)
}

resource "google_firebase_ai_logic_prompt_template_lock" "default" {
  count       = var.enable_lock ? 1 : 0
  provider    = google-beta
  project     = var.project_id
  location    = google_firebase_ai_logic_prompt_template.default.location
  template_id = google_firebase_ai_logic_prompt_template.default.template_id

  depends_on = [google_firebase_ai_logic_prompt_template.default]
}
