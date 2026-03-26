# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This changelog is generated automatically based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

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
