# Deployment Pipelines

This directory contains deployment pipeline configurations and examples for deploying applications to various environments.

## Available Pipelines

### Multi-Environment Deployment

The main deployment workflow (`../../.github/workflows/deploy.yml`) supports deployment to:
- **Development**: For testing and development
- **Staging**: For pre-production validation
- **Production**: For live production deployments

## Usage Examples

### Example 1: Deploy to Production

Create a workflow file in your repository (`.github/workflows/deploy-prod.yml`):

```yaml
name: Deploy to Production

on:
  push:
    branches:
      - main

jobs:
  deploy:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/deploy.yml@main
    with:
      environment: production
      dry_run: false
    secrets:
      deploy_key: ${{ secrets.DEPLOY_KEY }}
```

### Example 2: Deploy to Staging on Pull Request

```yaml
name: Deploy to Staging

on:
  pull_request:
    branches:
      - main

jobs:
  deploy:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/deploy.yml@main
    with:
      environment: staging
      dry_run: false
```

### Example 3: Manual Deployment with Dry Run

```yaml
name: Manual Deployment

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        type: choice
        options:
          - development
          - staging
          - production
      dry_run:
        description: 'Dry run mode'
        type: boolean
        default: true

jobs:
  deploy:
    uses: StruanCaughey/StruansPipelineScripts/.github/workflows/deploy.yml@main
    with:
      environment: ${{ inputs.environment }}
      dry_run: ${{ inputs.dry_run }}
```

## Customization

The deployment workflow can be customized by:
1. Adding environment-specific secrets
2. Configuring environment protection rules in GitHub
3. Extending the workflow with additional steps
4. Adding deployment approval gates

## Environment Setup

For each environment, configure the following in your repository settings:
1. Navigate to Settings → Environments
2. Create environments: `development`, `staging`, `production`
3. Add protection rules as needed
4. Configure environment secrets

## Best Practices

1. **Always test in development first**: Deploy to development environment before staging or production
2. **Use dry-run mode**: Test deployment workflows without making actual changes
3. **Enable approvals for production**: Require manual approval for production deployments
4. **Monitor deployments**: Set up notifications for deployment success/failure
5. **Rollback plan**: Have a strategy for rolling back failed deployments
