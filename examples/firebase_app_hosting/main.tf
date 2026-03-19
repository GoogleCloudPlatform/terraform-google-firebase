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

module "firebase_app" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_multi_platform_application"
  version = "~> 0.1"
  project_id = var.project_id

  apps = {
    web_app = {
      display_name = "App Hosting App"
    }
  }
}

module "app_hosting" {
  source  = "GoogleCloudPlatform/firebase/google//modules/firebase_app_hosting"
  version = "~> 0.1"
  project_id = var.project_id

  location   = "us-central1"
  backend_id = "example-backend"
  web_app_id = module.firebase_app.app_ids[0]

  build = {
    container_image = "us-docker.pkg.dev/cloudrun/container/hello"
  }
}
