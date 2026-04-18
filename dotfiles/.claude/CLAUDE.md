# Agent Instructions

## Development Environment

The development environment is a Mac Mini M4 Pro with 24GB of RAM running macOS Tahoe.

## Development Instructions

- When a choice is obvious, don't prompt for a human to make the choice.
- Always make use of the latest versions of packages/SDKs/images/tools in what you build.
- Always start projects with the infrastructure needed to properly build run and test the software, include scripts for a human to use that maintain a clean environment (e.g. automated standup and tear down).
- Always add strong linting/style rules with enforcement when starting a new project.
- Always add automated tests that will verify functionality being implemented.
- When implementing multiple tasks/issue/features, always update any progress records, verify the work is complete and functional (using tests), has no linting/style errors, relevant documentation is updated, and create a commit.
- Always implement tasks in their entirety, do not commit half-finished work.
- Always ensure you stick to the plan, and adjust it when you find it unworkable. When asked to implement the plan, work through each item systematically. Follow a similar approach to individual tasks when working through sections/components, where each one is verify as a whole before moving to the next one. Do not stop midway through the plan, implement it fully. When you believe you are done, go back and work through it.
- Always add a `README.md` to new projects, ensure it includes prerequisites required to work on the project.
- Favor running dependencies as containers.
- When working with Docker-based projects, always rebuild Docker images after code changes before testing. Remember that `docker compose up` does not automatically rebuild. Use `docker compose up --build` or `docker compose build` first.
- Always check that containers start up correctly and that there are no errors in the logs. If there are issues, investigate and resolve them before proceeding with further development or testing.
- When deleting or removing a component (service, module, dependency), audit ALL references: docker-compose entries, scripts, source code directories, documentation links, and configuration files. Do not consider the removal complete until all artifacts are cleaned up.
- When creating documentation, use Markdown and for diagrams, use embedded mermaid diagrams.
