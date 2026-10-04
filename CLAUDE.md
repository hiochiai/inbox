# Agent Context and Instructions

This document provides a set of core instructions and guidelines for any AI agent operating within this repository. You must adhere to these rules when performing tasks. Other instructions may be added to this file in the future.

---

## Documentation Maintenance Guidelines

This section outlines the guidelines for maintaining the quality and consistency of documentation within the `docs` directory.

### Core Principles

- **Clarity:** Provide concise and accurate information that helps users achieve their goals.
- **Consistency:** Use uniform terminology, formatting, and style across all documents.
- **Practicality:** Always include practical, copy-paste-ready command examples.

### Directory and Linking Structure

1.  **File Placement:**
    -   **Agent-Specific:** Documents that apply to a single agent (e.g., Gemini, Claude) must be placed in a subdirectory named after that agent (`docs/gemini/`, `docs/claude/`).
    -   **Common Documents:** Documents that apply to the `inbox` tool in general, regardless of the agent, must be placed directly under the `docs/` directory.

2.  **README.md as Entry Point:**
    -   The root `README.md` is the primary entry point for all documentation. All documentation files should be discoverable from it.
    -   Use relative links to documentation and runnable examples. Keep existing URLs working when consolidating pages.
    -   Group links under logical headings (e.g., `Profile Management`).
    -   Use `docs/README.md` as the purpose-oriented index. Link common procedures once; use a compact agent table for authentication, memory, and image differences.
    -   For common topics, link directly: `* [Manage profiles](./docs/profiles.md)`

3.  **Filenames:** Use descriptive, lowercase, snake_case or kebab-case English filenames (e.g., `creating_profiles.md`).

### Formatting Rules

- **Title:** Use a Markdown H2 (`##`) for the page title, describing the action clearly (e.g., `## Creating Profiles`).
- **Command Examples:**
    -   Enclose all command examples in `bash` code blocks.
    -   It is highly recommended to add a comment before the command explaining its purpose.
      ```bash
      # Create a 'work' profile
      inbox agent -p work
      ```
- **Steps:** Use numbered lists for procedures that require multiple steps.

### Style Rules

- **Tone:** Use a concise and direct tone. Minimize jargon.
- **Perspective:** Write from the user's point of view, explaining what they can do and why it's useful.
- **Short sentences:** Express one point per sentence. Aim for 10–20 words when practical.
- **Main topics:** Use one to three short sentences and one representative command. Link to reference pages for exceptions and implementation details.
- **Shared procedures:** Keep installation and common tasks in one canonical page. Agent pages should explain only differences or link to the shared steps.
- **Examples:** Use `work` as the usual profile name. Use another name when the task needs a separate profile, such as switching accounts.
- **Terms:** Use **unnamed profile** when no profile name is supplied. Reserve **default** for the saved startup selection. Prefer `inbox with no arguments` over `bare inbox`.
- **Existing settings:** Create files without truncating them. Tell readers to edit or merge settings rather than overwrite their files.
- **Essential warnings:** Keep file access and approval behavior near the relevant commands. Put deeper security details in the security model.

---

### **IMPORTANT: Autonomous Correction Mandate**

**This is the most critical guideline within the documentation maintenance section.**

When creating or updating documents, if you discover any significant issues in **any** existing document (e.g., incorrect commands, broken links, outdated information, or violations of these guidelines), you must **autonomously correct and update the relevant documents without waiting for user instruction.**

Your role is to ensure the entire documentation set remains accurate, consistent, and up-to-date at all times.
