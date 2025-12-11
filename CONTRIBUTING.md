# Contributing to StruansPipelineScripts

Thank you for considering contributing to this repository! This document provides guidelines for contributing pipelines, workflows, and scripts.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a new branch for your changes
4. Make your changes
5. Test your changes
6. Submit a pull request

## Types of Contributions

### 1. New Pipelines

When adding new pipelines:
- Place deployment pipelines in `pipelines/deployment/`
- Place versioning workflows in `pipelines/semver/`
- Include comprehensive documentation
- Provide usage examples

### 2. Workflow Improvements

- Update workflows in `.github/workflows/`
- Ensure backward compatibility when possible
- Document breaking changes clearly
- Test workflows thoroughly

### 3. Utility Scripts

- Add scripts to `scripts/`
- Make scripts executable (`chmod +x`)
- Include usage documentation
- Add error handling

### 4. Documentation

- Update relevant README files
- Provide clear examples
- Include troubleshooting sections
- Keep documentation in sync with code

## Coding Standards

### GitHub Actions Workflows

```yaml
# Use descriptive names
name: Clear and Descriptive Name

# Document inputs and outputs
inputs:
  parameter:
    description: 'Clear description'
    required: true
    type: string

# Add comments for complex logic
- name: Step with complex logic
  run: |
    # Explain what this does
    echo "Clear operation"
```

### Shell Scripts

```bash
#!/bin/bash

# Script purpose and usage
# Usage: ./script.sh [arguments]

set -e  # Exit on error

# Use functions for reusability
function_name() {
    # Function logic
    echo "Clear output"
}

# Document complex operations
# This section does X, Y, and Z
```

## Testing

### Workflow Testing

1. Test in a fork or branch first
2. Use workflow_dispatch for manual testing
3. Validate with different inputs
4. Check outputs and logs

### Script Testing

1. Test locally before committing
2. Verify error handling
3. Test edge cases
4. Validate on different systems if applicable

## Pull Request Process

1. **Update Documentation**: Ensure all changes are documented
2. **Add Examples**: Include usage examples for new features
3. **Test Thoroughly**: Verify changes work as expected
4. **Follow Conventions**: Match existing code style
5. **Describe Changes**: Provide clear PR description

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New pipeline/workflow
- [ ] Bug fix
- [ ] Documentation update
- [ ] Script improvement

## Testing
Describe testing performed

## Checklist
- [ ] Documentation updated
- [ ] Examples provided
- [ ] Code tested
- [ ] Follows conventions
```

## Commit Messages

Follow conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `refactor`: Code refactoring
- `test`: Testing changes
- `chore`: Maintenance tasks

**Examples:**
```bash
feat(deployment): add multi-region deployment support
fix(semver): correct version parsing for pre-release tags
docs(readme): update usage examples
```

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help others learn and grow

## Questions?

If you have questions or need help:
1. Check existing documentation
2. Search for similar issues
3. Open a new issue with your question

## License

By contributing, you agree that your contributions will be licensed under the same license as this project.
