# Contributing to City of New Orleans Network Standards

Thank you for your interest in contributing to the City of New Orleans network standards documentation. This guide explains how to suggest changes, report issues, and submit contributions.

## Ways to Contribute

### Option 1: Submit an Issue (Easiest)

Best for: Suggestions, error reports, questions, or if you're not familiar with Git.

1. Go to the [Issues page](https://github.com/NewOrleansITI/network-standards/issues)
2. Click **"New Issue"**
3. Select the appropriate template:
   - **Standard Update Request** — Suggest changes to existing standards
   - **New Documentation Request** — Request new documentation be added
   - **Bug Report** — Report errors or outdated information
4. Fill out the template and submit

A maintainer will review your issue and respond.

### Option 2: Submit a Pull Request (For Direct Changes)

Best for: Technical contributors who want to directly propose documentation changes.

1. **Fork the repository** — Click the "Fork" button on the main repo page
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/network-standards.git
   cd network-standards
   ```
3. **Create a branch** for your changes:
   ```bash
   git checkout -b update/descriptive-branch-name
   ```
4. **Make your changes** to the Markdown files
5. **Commit your changes** with a clear message:
   ```bash
   git add .
   git commit -m "Update cabling standards to include Cat6A requirements"
   ```
6. **Push to your fork**:
   ```bash
   git push origin update/descriptive-branch-name
   ```
7. **Open a Pull Request** from your fork to the main repository

## Documentation Standards

When contributing documentation, please follow these guidelines:

### Formatting
- Use Markdown formatting
- Use clear, descriptive headings (H2 for main sections, H3 for subsections)
- Include a "Last Updated" date at the top of each document
- Use tables for specifications and comparisons

### Content
- Be specific and technical — include model numbers, versions, and measurable requirements
- Explain the "why" behind standards when helpful
- Include references to vendor documentation where applicable
- Use consistent terminology throughout

### File Naming
- Use lowercase with hyphens: `cabling-standards.md`
- Be descriptive: `poe-switch-requirements.md` not `switches.md`

## Review Process

1. All contributions are reviewed by the ITI Networking Team
2. We may request changes or clarification
3. Once approved, changes are merged into the main branch
4. GitHub Pages automatically updates the public documentation

## Code of Conduct

- Be respectful and professional
- Focus on technical accuracy
- Assume good intent from other contributors
- Keep discussions focused on improving the documentation

## Questions?

- Open an issue with the **Question** label
- Contact the ITI Networking Team at networkingteam@nola.gov

---

Thank you for helping improve City of New Orleans network standards!
