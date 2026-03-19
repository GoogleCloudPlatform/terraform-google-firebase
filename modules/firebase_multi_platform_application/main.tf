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

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id
}

resource "google_firebase_web_app" "default" {
  count        = var.apps.web_app != null && try(length(var.apps.web_app.display_name) > 0, false) ? 1 : 0
  provider     = google-beta
  project      = google_firebase_project.default.project
  display_name = var.apps.web_app.display_name
  api_key_id   = var.apps.web_app.api_key_id
}

resource "google_firebase_android_app" "default" {
  count         = var.apps.android_app != null && try(length(var.apps.android_app.package_name) > 0, false) ? 1 : 0
  provider      = google-beta
  project       = google_firebase_project.default.project
  display_name  = coalesce(var.apps.android_app.display_name, var.apps.android_app.package_name)
  package_name  = var.apps.android_app.package_name
  sha256_hashes = var.apps.android_app.sha256_hashes
}

resource "google_firebase_apple_app" "default" {
  count        = var.apps.apple_app != null && try(length(var.apps.apple_app.bundle_id) > 0, false) ? 1 : 0
  provider     = google-beta
  project      = google_firebase_project.default.project
  display_name = coalesce(var.apps.apple_app.display_name, var.apps.apple_app.bundle_id)
  bundle_id    = var.apps.apple_app.bundle_id
  team_id      = var.apps.apple_app.team_id
}

data "google_firebase_web_app_config" "default" {
  count      = var.apps.web_app != null && try(length(var.apps.web_app.display_name) > 0, false) ? 1 : 0
  provider   = google-beta
  project    = google_firebase_project.default.project
  web_app_id = google_firebase_web_app.default[0].app_id
}

data "google_firebase_android_app_config" "default" {
  count    = var.apps.android_app != null && try(length(var.apps.android_app.package_name) > 0, false) ? 1 : 0
  provider = google-beta
  project  = google_firebase_project.default.project
  app_id   = google_firebase_android_app.default[0].app_id
}

data "google_firebase_apple_app_config" "default" {
  count    = var.apps.apple_app != null && try(length(var.apps.apple_app.bundle_id) > 0, false) ? 1 : 0
  provider = google-beta
  project  = google_firebase_project.default.project
  app_id   = google_firebase_apple_app.default[0].app_id
}
