# Gemini Developer Guide

Welcome to the `terraform-google-firebase` repository. This file serves as a quick reference for AI agents to navigate the project's documentation and established skills.

## Project Documentation

- [README.md](./README.md): Main overview and usage instructions.
- [CONTRIBUTING.md](./CONTRIBUTING.md): Guidelines for contributing to the repository.
- [SECURITY.md](./SECURITY.md): Security policies.
- [CHANGELOG.md](./CHANGELOG.md): History of notable changes.

## AI Agent Skills

Available sub-routines (skills) for AI agents operating in this repository:

- **`conventional-commits`**: Located in [`.agent/skills/conventional_commits.md`](./.agent/skills/conventional_commits.md), this skill provides strict instructions on standardizing Pull Requests and commit messages for CHANGELOG generation (e.g. `feat:`, `fix:`, `feat!:`).
- **`skill-authoring`**: Located in [`.agent/skills/skill_authoring.md`](./.agent/skills/skill_authoring.md), this skill outlines exactly how agents should write, format, and document new skills within the repository.
- **`markdown-linting`**: Located in [`.agent/skills/markdown_linting.md`](./.agent/skills/markdown_linting.md), this skill mandates that agents execute the `make docker_format_md` command before finalizing pull requests involving documentation to ensure compliance with strict PR linting checks.
- **`metadata-linting`**: Located in [`.agent/skills/metadata_linting.md`](./.agent/skills/metadata_linting.md), explains that `ENABLE_BPMETADATA=1` is strictly required in `Makefile` targets to mandate metadata validation in tests.
