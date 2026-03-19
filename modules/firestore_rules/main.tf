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
  # Split the string by "/"
  parts = split("/", var.database_id)

  # Grab the last element of the resulting list
  db_id = element(local.parts, length(local.parts) - 1)
}

resource "google_firebaserules_release" "release" {
  project      = var.project_id
  name         = local.db_id == "(default)" ? "cloud.firestore" : "cloud.firestore/${local.db_id}"
  ruleset_name = google_firebaserules_ruleset.ruleset.name
}

resource "google_firebaserules_ruleset" "ruleset" {
  project = var.project_id
  source {
    files {
      name    = "firestore.rules"
      content = var.rules_content
    }
  }
}
