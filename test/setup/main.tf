/**
 * Copyright 2019 Google LLC
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
  per_module_services = {
    firebase_ai_logic_core = [
      "apikeys.googleapis.com",
      "firebase.googleapis.com",
      "firebasevertexai.googleapis.com",
      "serviceusage.googleapis.com"
    ]
    firebase_ai_logic_prompt_template = [
      "firebase.googleapis.com",
      "firebasevertexai.googleapis.com",
      "serviceusage.googleapis.com",
      "storage.googleapis.com"
    ]
    firebase_app_check = [
      "firebaseappcheck.googleapis.com",
      "serviceusage.googleapis.com"
    ]
    firebase_app_hosting = [
      "firebaseapphosting.googleapis.com",
      "iam.googleapis.com",
      "serviceusage.googleapis.com"
    ]
    firebase_auth = [
      "identitytoolkit.googleapis.com",
      "firebasehosting.googleapis.com",
      "serviceusage.googleapis.com"
    ]
    firebase_multi_platform_application = [
      "firebase.googleapis.com",
      "serviceusage.googleapis.com"
    ]
    firestore_rules = [
      "firestore.googleapis.com",
      "firebaserules.googleapis.com",
      "serviceusage.googleapis.com"
    ]
  }
}
module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 17.0"

  name              = "cft-firebase-ci"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = var.folder_id
  billing_account   = var.billing_account

  activate_apis = distinct(concat([
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com"
  ], flatten(values(local.per_module_services))))

  deletion_policy = "DELETE"
}
