---
name: skill-authoring
description: Guidelines for authoring new AI agent skills in this repository.
---
# Skill Authoring Guide

This repository uses AI agent skills to establish standardized patterns, workflows, and conventions. When tasked with creating a new skill or updating an existing one, AI agents must adhere to the following authoring guidelines:

## Skill Creation Rules

1. **File Location**: All new skills MUST be created in the `.agent/skills/` directory as Markdown documents (`.md`).
2. **Naming Convention**: Use descriptive, localized names (e.g., `feature_development.md`, `testing_patterns.md`).
3. **YAML Frontmatter**: Every skill file MUST begin with YAML frontmatter containing `name` and `description` to allow parsing by other agents or tooling.

   ```yaml
   ---
   name: your-skill-name
   description: Brief explanation of what this skill codifies.
   ---
   ```

4. **Actionable Instructions**: Skills should provide explicit, chronological instructions and rules for agents to follow when performing tasks in the repository. Avoid overly broad or generalized statements that can lead to hallucination.

## Updating the Directory Index (`GEMINI.md`)

After successfully creating or updating a skill in `.agent/skills/`, you MUST document it in the project's central index:

1. Open `GEMINI.md` located at the root of the repository.
2. Locate the `## AI Agent Skills` heading.
3. Append a bulleted entry for your new skill following the established format:
   `- **`skill-name`**: Located in [\`.agent/skills/filename.md\`](./.agent/skills/filename.md), [brief one-sentence summary of the skill].`

By following these guidelines, you will ensure a well-maintained, easily discoverable ecosystem of agent capabilities for this project.
