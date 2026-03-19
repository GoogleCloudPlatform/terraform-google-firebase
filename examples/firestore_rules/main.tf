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

resource "random_id" "database_suffix" {
  byte_length = 4
}

resource "google_firestore_database" "database" {
  project     = var.project_id
  name        = "test-database-${random_id.database_suffix.hex}"
  location_id = var.location
  type        = "FIRESTORE_NATIVE"
}

module "firestore_rules" {
  source        = "GoogleCloudPlatform/firebase/google//modules/firestore_rules"
  version       = "~> 0.1"
  project_id    = var.project_id
  database_id   = google_firestore_database.database.name
  rules_content = <<EOT
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
EOT
}
