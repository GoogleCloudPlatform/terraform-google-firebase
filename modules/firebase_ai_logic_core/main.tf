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


# 2. Enable Required APIs
resource "google_project_service" "vertexai" {
  count              = var.api_config.vertex_ai ? 1 : 0
  provider           = google-beta
  project            = var.project_id
  service            = "aiplatform.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "gemini" {
  count              = var.api_config.gemini_developer ? 1 : 0
  provider           = google-beta
  project            = var.project_id
  service            = "generativelanguage.googleapis.com"
  disable_on_destroy = false
}

resource "random_id" "gemini_key_suffix" {
  count       = var.api_config.gemini_developer ? 1 : 0
  byte_length = 4
  prefix      = "ailogic-gemini-"
}

# 3. Generate Gemini API Key (if enabled)
resource "google_apikeys_key" "gemini" {
  count        = var.api_config.gemini_developer ? 1 : 0
  provider     = google-beta
  project      = var.project_id
  name         = random_id.gemini_key_suffix[0].hex
  display_name = "Gemini API Key for Firebase AI Logic"

  restrictions {
    api_targets {
      service = "generativelanguage.googleapis.com"
    }
  }

  depends_on = [google_project_service.gemini]
}

# 4. AI Logic Configuration
resource "google_firebase_ai_logic_config" "default" {
  provider = google-beta
  project  = var.project_id
  # Only global location is supported at the moment
  location = "global"

  dynamic "generative_language_config" {
    for_each = var.api_config.gemini_developer ? [1] : []
    content {
      api_key = google_apikeys_key.gemini[0].key_string
    }
  }

  telemetry_config {
    mode          = var.telemetry_mode
    sampling_rate = var.telemetry_sampling_rate
  }
}
