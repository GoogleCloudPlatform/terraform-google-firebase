---
name: markdown-linting
description: Strict guidelines for all AI agents to format and lint Markdown documents before opening Pull Requests.
---
# Markdown Formatting and Linting

This repository enforces strict Markdown syntax formatting for all `.md` files (including `GEMINI.md` and any `.agent/` skill documentation) via GitHub Actions (`lint-md.yml`).

Because the Pull Request will block any unformatted Markdown, **AI Agents MUST format all modified Markdown code locally before creating a Pull Request.**

## How to use this skill

1. Make your required changes or author your new `.md` files anywhere within the repository.
2. Once your documentation changes are functionally complete, you **MUST** run the formatting command.
3. Use your CLI/Terminal tool to execute the global formatter via Make:

   ```bash
   make docker_format_md
   ```

4. Only after this command has successfully auto-fixed the formatting issues are you allowed to commit your changes and proceed with `create_pull_request`.
