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

variable "project_id" {
  description = "The project ID."
  type        = string
}

variable "location" {
  description = "The location for the prompt template."
  type        = string
  default     = "global"
}

variable "template_id" {
  description = "The unique identifier for the prompt template."
  type        = string
}

variable "template_content" {
  description = "Prompt template content. Can either be specified as a raw string or a Google Cloud Storage object"
  type = object({
    raw = optional(string)
    gcs_object_source = optional(object({
      bucket = string
      name   = string
    }))
  })
}

variable "enable_lock" {
  description = "Whether to create a production lock for the prompt template."
  type        = bool
  default     = false
}
