# Contributing to the Ansible Playbook Repository
Welcome to the Ansible Playbook Repository! We appreciate your interest in contributing to this project. This document outlines the guidelines and best practices for contributing. By following these guidelines, you can help ensure a smooth and collaborative development process.

## Table of Contents
- [Getting Started](#getting-started)
- [Creating Issues](#creating-issues)
- [Making Changes](#making-changes)
- [Pull Requests](#pull-requests)
- [Style Guidelines](#style-guidelines)
- [Code of Conduct](./CODE_OF_CONDUCT.md)
## Getting Started
Before contributing to the project, please make sure you have the following:

1. **A GitHub account:** If you don't have one, you can sign up at https://github.com/join.
2. **Git**: You'll need to have hit installed on your local machine to clone the repository and make changes.
3. **Ansible**: Familiarity with Ansible is recommended to understand the existing playbook structure and syntax.
## Creating Issues
If you encounter a bug, have a feature request, or want to suggest an improvement, you can create an issue on the GitHub repository. Follow these guidelines when creating issues:

1. **Search for existing** issues: Before creating a new issue, search the existing issues to see if your concern has already been raised.
2. **Provide a clear and descriptive title:** Use a title that accurately summarizes the issue or feature request.
3. **Detailed description**: In the issue description, provide as much information as possible, including steps to reproduce the problem or a detailed explanation of the desired feature.
4. **Labels and assignees**: Apply relevant labels and assignees to the issue to help categorize and assign it appropriately.
## Making Changes
To contribute to the Ansible Playbook Repository, follow these steps:

1. **Fork the repository:** Fork the repository to your GitHub account by clicking on the "Fork" button at the top of the repository page.
2. **Clone the repository:** Clone the forked repository to your local machine using the git clone command.
3. **Create a branch:** Create a new branch for your changes using a descriptive name. Branch names should be concise and include a relevant prefix (e.g., `feature/new-feature`, `bugfix/issue-123`).
4. **Make changes:** Make the necessary changes to the playbook files and any associated documentation.
5. **Commit your changes:** Commit your changes with a clear and concise commit message, following the style guidelines below.
6. **Push changes:** Push your branch to your forked repository on GitHub.
7. **Create a pull request:** Open a pull request on the original repository, comparing your branch to the main branch.
8. **Review and iterate:** Collaborate with the community and address any feedback or requested changes during the review process.
9. **Merge:** Once your pull request has been approved and meets the project's guidelines, it will be merged into the main branch.
## Pull Requests
When submitting a pull request, please consider the following guidelines:

1. **One feature or bug fix per pull request:** Submit separate pull requests for each individual feature or bug fix to ensure a focused review process.
2. **Provide a clear description:** Describe the purpose and scope of your changes in the pull request description, providing any relevant information that may assist with the review.
3. **Referencing issues:** If your pull request addresses an existing issue, reference it in the description using the #issue_number syntax.
4. **Test your changes:** Ensure that your changes do not introduce new issues and test them thoroughly before submitting a pull request.
## Style Guidelines
### Git Commit Messages
When committing changes to the repository, please adhere to the following guidelines for writing effective commit messages:

**Use short and concise summary messages:** Start the commit message with a brief summary of the changes made. Limit the summary to 50 characters or less and use present tense.

Example: "Fix typo in README.md"

**Provide additional details in the commit body:** Include a more detailed description of the changes in the commit body. This can help other contributors understand the context and purpose of the changes.

Example:

```text
Fix typo in README.md
```

The word "committer" was misspelled as "committor" in line 42 of the README file. This commit corrects the typo.
**Use bullet points and lists:** If necessary, use bullet points or lists to provide clear and organized information about the changes made.

Example:

```text
Add new feature to user interface

- Introduce a settings panel with customizable options
- Implement a dark mode theme toggle button
- Enhance user profile page with additional user details
```
### Committing Issue and Pull Request IDs
To associate your commits with relevant GitHub issues or pull requests, include the corresponding IDs in your commit messages. This helps in tracking and maintaining a clear history of changes.

#### Committing Issue IDs
If your commit addresses an open issue, include the issue number in the commit message. Use the keyword "Fixes" or "Closes" followed by the issue number.

Example:

```bash
Fixes #123: Implement login functionality
```
#### Committing Pull Request IDs
When your commit is related to a specific pull request, include the pull request number in the commit message. Use the keyword "Refs" followed by the pull request number.

Example:

```text
Refs #456: Address feedback in pull request
```
By including these IDs, GitHub will automatically cross-reference your commits with the corresponding issues or pull requests, providing a clear and concise history of changes.
