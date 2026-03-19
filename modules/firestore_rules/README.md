# Firestore Rules Submodule

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0, < 8.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.0, < 8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_firebaserules_release.release](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebaserules_release) | resource |
| [google_firebaserules_ruleset.ruleset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebaserules_ruleset) | resource |
| [google_storage_bucket_object_content.rules](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket_object_content) | data source |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database\_id | The Firestore database id, use `(default)` for the default database. | `string` | n/a | yes |
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| rules\_content | The security rules to apply. | `string` | `"rules_version = '2';\nservice cloud.firestore {\n  match /databases/{database}/documents {\n    match /{document=**} {\n      allow read, write: if false;\n    }\n  }\n}\n"` | no |

## Outputs

| Name | Description |
|------|-------------|
| release\_name | The name of the release. |
| ruleset\_name | The name of the ruleset. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
