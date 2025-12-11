# Semantic Versioning Pipelines

This directory contains semantic versioning workflows for automated version tagging and release management.

## Overview

The semantic versioning workflow automatically determines version bumps based on:
- **Conventional Commits**: Analyzes commit messages to determine version changes
- **Manual Triggers**: Allows manual specification of version bump type

## Versioning Rules

The workflow follows Semantic Versioning (SemVer) principles:

- **Major Version (x.0.0)**: Breaking changes
  - Commit messages with `BREAKING CHANGE:`
  - Commits like `feat!:` or `fix!:`
  
- **Minor Version (0.x.0)**: New features (backward compatible)
  - Commit messages starting with `feat:`
  
- **Patch Version (0.0.x)**: Bug fixes (backward compatible)
  - Commit messages starting with `fix:`
  - Default for other commits

## Usage Examples

### Example 1: Automatic Version Tagging on Release

Create a workflow file in your repository (`.github/workflows/release.yml`):

```yaml
name: Create Release

on:
  push:
    branches:
      - main

jobs:
  version:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/semver-tag.yml@main
    with:
      bump_type: auto
      create_release: true
    permissions:
      contents: write
```

### Example 2: Manual Version Tagging

```yaml
name: Manual Version Tag

on:
  workflow_dispatch:
    inputs:
      bump_type:
        description: 'Version bump type'
        required: true
        type: choice
        options:
          - auto
          - major
          - minor
          - patch
      create_release:
        description: 'Create GitHub release'
        type: boolean
        default: true

jobs:
  version:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/semver-tag.yml@main
    with:
      bump_type: ${{ inputs.bump_type }}
      create_release: ${{ inputs.create_release }}
    permissions:
      contents: write
```

### Example 3: Tag and Deploy

```yaml
name: Tag and Deploy

on:
  workflow_dispatch:

jobs:
  tag:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/semver-tag.yml@main
    with:
      bump_type: auto
      create_release: true
    permissions:
      contents: write

  deploy:
    needs: tag
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/deploy.yml@main
    with:
      environment: production
    secrets: inherit
```

## Conventional Commits

For automatic version determination, follow the Conventional Commits specification:

### Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Examples

```bash
# Patch version bump (0.0.x)
git commit -m "fix: resolve authentication bug"

# Minor version bump (0.x.0)
git commit -m "feat: add user profile page"

# Major version bump (x.0.0)
git commit -m "feat!: redesign API endpoints

BREAKING CHANGE: API endpoints have been restructured"
```

## Version Output

The workflow outputs the new version, which can be used in subsequent jobs:

```yaml
jobs:
  version:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/semver-tag.yml@main
    with:
      bump_type: auto

  use-version:
    needs: version
    runs-on: ubuntu-latest
    steps:
      - name: Use new version
        run: |
          echo "New version: ${{ needs.version.outputs.new_version }}"
```

## Best Practices

1. **Use conventional commits**: Adopt conventional commit messages for automatic versioning
2. **Protect main branch**: Require pull requests to ensure proper commit messages
3. **Review before tagging**: Use manual triggers for important releases
4. **Tag on merge**: Automatically tag versions when merging to main/master
5. **Create releases**: Enable release creation for better tracking and changelog generation
