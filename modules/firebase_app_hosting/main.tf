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

locals {
  service_account = var.service_account != null ? var.service_account : google_service_account.service_account[0].email
}

resource "google_firebase_app_hosting_backend" "backend" {
  project = var.project_id

  location         = var.location
  backend_id       = var.backend_id
  app_id           = var.web_app_id
  serving_locality = "GLOBAL_ACCESS"
  service_account  = local.service_account
  environment      = var.environment
}

resource "google_service_account" "service_account" {
  count   = var.service_account == null ? 1 : 0
  project = var.project_id

  # Must be firebase-app-hosting-compute
  account_id   = "firebase-app-hosting-compute"
  display_name = "Firebase App Hosting compute service account"

  # Do not throw if already exists
  create_ignore_already_exists = true
}

resource "google_project_iam_member" "app_hosting_sa_runner" {
  project = var.project_id

  # For App Hosting
  role   = "roles/firebaseapphosting.computeRunner"
  member = "serviceAccount:${local.service_account}"
}

resource "random_string" "build_id" {
  length  = 16
  special = false

  # Upper case letters not allowed
  upper = false

  keepers = {
    "image" = var.build.container_image
  }
}

resource "time_sleep" "wait_before_build" {
  create_duration = "120s"

  depends_on = [
    google_firebase_app_hosting_backend.backend,
    google_project_iam_member.app_hosting_sa_runner
  ]
}

resource "google_firebase_app_hosting_build" "build" {
  project  = google_firebase_app_hosting_backend.backend.project
  location = google_firebase_app_hosting_backend.backend.location
  backend  = google_firebase_app_hosting_backend.backend.backend_id
  build_id = "build-${random_string.build_id.result}"

  depends_on = [
    time_sleep.wait_before_build
  ]

  source {
    container {
      image = var.build.container_image
    }
  }
}

resource "google_firebase_app_hosting_traffic" "traffic" {
  project  = google_firebase_app_hosting_backend.backend.project
  location = google_firebase_app_hosting_backend.backend.location
  backend  = google_firebase_app_hosting_backend.backend.backend_id

  target {
    splits {
      build   = google_firebase_app_hosting_build.build.name
      percent = 100
    }
  }
}
