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

# Service Enforcement
resource "google_firebase_app_check_service_config" "default" {
  for_each         = toset(var.service_ids)
  provider         = google-beta
  project          = var.project_id
  service_id       = each.value
  enforcement_mode = var.enforcement_mode
}

# Play Integrity (Android)
resource "google_firebase_app_check_play_integrity_config" "default" {
  for_each  = { for i, app in var.android_apps : tostring(i) => app if app != null }
  provider  = google-beta
  project   = var.project_id
  app_id    = each.value.app_id
  token_ttl = each.value.token_ttl
}

# App Attest (Apple)
resource "google_firebase_app_check_app_attest_config" "default" {
  for_each  = { for i, app in var.apple_apps : tostring(i) => app if app != null && try(app.app_attest, false) == true }
  provider  = google-beta
  project   = var.project_id
  app_id    = each.value.app_id
  token_ttl = each.value.token_ttl
}

# Device Check (Apple)
resource "google_firebase_app_check_device_check_config" "default" {
  for_each    = { for i, app in var.apple_apps : tostring(i) => app if app != null && try(app.device_check, null) != null }
  provider    = google-beta
  project     = var.project_id
  app_id      = each.value.app_id
  private_key = each.value.device_check.private_key
  key_id      = each.value.device_check.key_id
  token_ttl   = each.value.token_ttl
}

# reCAPTCHA Enterprise (Web)
resource "google_firebase_app_check_recaptcha_enterprise_config" "default" {
  for_each = { for i, app in var.web_apps : tostring(i) => app if app != null && try(app.site_key, null) != null }
  provider = google-beta
  project  = var.project_id
  app_id   = each.value.app_id
  site_key = each.value.site_key
}

# reCAPTCHA v3 (Web)
resource "google_firebase_app_check_recaptcha_v3_config" "default" {
  for_each    = { for i, app in var.web_apps : tostring(i) => app if app != null && try(app.recaptcha_v3_secret, null) != null }
  provider    = google-beta
  project     = var.project_id
  app_id      = each.value.app_id
  site_secret = each.value.recaptcha_v3_secret
  token_ttl   = each.value.token_ttl
}

# Debug Tokens
resource "google_firebase_app_check_debug_token" "tokens" {
  for_each     = { for i, token in var.debug_tokens : tostring(i) => token }
  provider     = google-beta
  project      = var.project_id
  app_id       = each.value.app_id
  display_name = each.value.display_name
  token        = each.value.token
}
