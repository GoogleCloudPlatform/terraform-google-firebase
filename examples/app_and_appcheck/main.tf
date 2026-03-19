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

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

module "multi_platform_app" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_multi_platform_application"
  version = "~> 0.1"
  project_id = var.project_id

  apps = {
    web_app = {
      display_name = "App Check Web App"
      app_check_config = {
        enable             = true
        recaptcha_site_key = "6Ld_e7YUAAAAAMXJ2a7X_Z1Hk2p_M1z1G2h_Q2_3"
      }
    }
    android_app = {
      display_name = "App Check Android App"
      package_name = "com.google.appcheckandroid.complex"
      sha256_hashes = [
        "a1b2c3d4e5f67890123456789012345678901234567890123456789012345678"
      ]
      app_check_config = {
        enable = true
      }
    }
    apple_app = {
      display_name = "App Check iOS App"
      bundle_id    = "com.google.appcheckios.complex"
      team_id      = "1234567890"
      app_check_config = {
        enable_app_attest = true
      }
    }
  }
}

module "app_check" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_app_check"
  version = "~> 0.1"
  project_id = var.project_id

  service_ids = [
    "identitytoolkit.googleapis.com"
  ]

  android_apps = module.multi_platform_app.app_check_bundle.android
  apple_apps   = module.multi_platform_app.app_check_bundle.apple
  web_apps     = module.multi_platform_app.app_check_bundle.web
  debug_tokens = module.multi_platform_app.app_check_bundle.debug_tokens
}
