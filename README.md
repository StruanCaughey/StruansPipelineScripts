# StruansPipelineScripts

A comprehensive repository for deployment pipelines and supporting automation scripts, including semantic versioning (semver) tagging and other CI/CD utilities.

## Overview

This repository provides reusable GitHub Actions workflows and pipeline scripts for:
- **Deployment Pipelines**: Automated deployment workflows for different environments
- **Semantic Versioning**: Automated version tagging and release management
- **Supporting Scripts**: Utility scripts for pipeline automation

## Repository Structure

```
StruansPipelineScripts/
├── .github/
│   └── workflows/          # GitHub Actions workflow definitions
├── pipelines/
│   ├── deployment/         # Deployment pipeline configurations
│   └── semver/            # Semantic versioning workflows
├── scripts/               # Utility scripts
└── README.md
```

## Quick Start

### Deployment Pipelines

The deployment pipelines support multiple environments:
- **Development**: Automatic deployment on push to dev branch
- **Staging**: Deployment on push to staging branch
- **Production**: Deployment on push to main/master branch or manual trigger

### Semantic Versioning

Automatic version tagging based on commit messages following conventional commits:
- `feat:` → Minor version bump (0.x.0)
- `fix:` → Patch version bump (0.0.x)
- `BREAKING CHANGE:` → Major version bump (x.0.0)

## Usage

### Using Workflows in Other Repositories

You can reference these workflows in your repositories using GitHub's reusable workflows feature:

```yaml
jobs:
  deploy:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/deploy.yml@main
    with:
      environment: production
```

### Local Script Execution

Scripts can be executed locally or integrated into your CI/CD pipelines:

```bash
# Example: Version tagging
./scripts/semver-tag.sh
```

## Contributing

Contributions are welcome! Please ensure:
1. Workflows are well-documented
2. Scripts include error handling
3. Examples are provided for new features

## License

This repository is provided as-is for pipeline automation purposes.