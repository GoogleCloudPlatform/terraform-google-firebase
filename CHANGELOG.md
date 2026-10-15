# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This changelog is generated automatically based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

## [0.2.4](https://github.com/GoogleCloudPlatform/terraform-google-firebase/compare/v0.2.3...v0.2.4) (2026-10-15)


### Bug Fixes

* populate null defaultValue in firebase-app-hosting blueprint metadata ([#32](https://github.com/GoogleCloudPlatform/terraform-google-firebase/issues/32)) ([6fcba74](https://github.com/GoogleCloudPlatform/terraform-google-firebase/commit/6fcba7409bd658f3f5e8496d83b15420cd17c0f1))
* populate null defaultValue in firebase-auth blueprint metadata ([#33](https://github.com/GoogleCloudPlatform/terraform-google-firebase/issues/33)) ([cc9293e](https://github.com/GoogleCloudPlatform/terraform-google-firebase/commit/cc9293eea62ad7abe7e419e2e5cee14e5da740f8))

## [0.2.3](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.2.3) - 2026-04-08

### Features

- Add Firebase Hosting to list of enabled APIs for Auth module

## [0.2.2](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.2.2) - 2026-04-01

### Bug Fixes

- Rephrase Firebase web app API key to be more explicit
- Remove recaptcha_site_key requirement for Web App Check
- Enable telemetry APIs for AI Logic

### Documentation

- Clarity improvements for enable_auth_management variable

### Features

- Add `backend_uri`, `service_account`, and `environment` inputs to Firebase App Hosting

## [0.2.1](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.2.1) - 2026-03-29

### Bug Fixes

- Add enumValueLabels for location in metadata display
- Fix example tests for auth and metadata.yaml outputs

## [0.2.0](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.2.0) - 2026-03-26

### Bug Fixes

- Remove cyclic project_id connections
- Fix iam roles and metadata

### Features

- Add other supported variables for Firebase Auth

## [0.1.3](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.1.3) - 2026-03-26

### Bug Fixes

- Add sms_region_config to auth
- Add serviceAccountUser role to required by App Hosting

### Features

- Add authorized_domain input to Firebase Auth

## [0.1.2](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.1.2) - 2026-03-24

### Bug Fixes

- Update `firebase_ai_logic_prompt_template` 's `template_content` field description
- Regenerate metadata and require serviceusage API in all modules

## [0.1.1](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.1.1) - 2026-03-23

### Bug Fixes

- Remove no longer applicable connection for ai logic template location

### Features

- Add incoming connections from other components to Firebase modules

## [0.1.0](https://github.com/GoogleCloudPlatform/terraform-google-firebase/releases/tag/v0.1.0) - 2026-03-19

### Features

- Initial release
