---
name: conventional-commits
description: Standardized conventions for creating Pull Requests and commit messages for CHANGELOG generation.
---
# Conventional PR and Commit Messages

This repository strictly enforces conventional commit messages via GitHub Actions. Any PR that fails this convention will be blocked from merging.

## PR Title Formatting rules

When creating a new PR or writing commit messages, you MUST adhere to the following prefix rules based on the type of change you are introducing.

- `fix:` Use this for any code fixes or bug resolutions. (Triggers a `patch` release)
- `feat:` Use this for any new feature additions. (Triggers a `minor` release)
- `docs:` Use this for documentation changes.
- `chore:` Use this for maintenance tasks, build process changes, etc.
- `test:` Use this for adding or fixing tests.
- `refactor:` Use this for code changes that neither fix a bug nor add a feature.

### Breaking Changes

- `feat!:` or `fix!:` Use the `!` indicator for any updates that introduce breaking changes and require a major release.
- Alternatively, include `BREAKING CHANGE: <description>` in the body of the PR/commit.

## How to use this skill

1. Before running `create_pull_request`, ensure your `title` parameter strictly adheres to the format: `<type>: <description>`. For example: `fix: resolve IAM permission denied error`.
2. Do not capitalize the first letter of the description or add a trailing period.
3. If making a breaking change, highlight it clearly in the PR body.
