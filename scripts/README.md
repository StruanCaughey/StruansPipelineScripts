# Utility Scripts

This directory contains utility scripts for pipeline automation and management.

## Available Scripts

### semver-tag.sh

Automated semantic version tagging script that can be run locally.

**Usage:**

```bash
# Automatic version bump based on commit messages
./scripts/semver-tag.sh

# Manual version bump
./scripts/semver-tag.sh major   # Bump major version
./scripts/semver-tag.sh minor   # Bump minor version
./scripts/semver-tag.sh patch   # Bump patch version
```

**Features:**
- Analyzes commit history to determine version bump type
- Follows conventional commit standards
- Interactive confirmation before creating tags
- Optional push to remote

**Requirements:**
- Git repository
- Proper commit message formatting (for auto mode)

## Script Development

When adding new scripts:

1. **Make scripts executable**: `chmod +x scripts/script-name.sh`
2. **Add error handling**: Use `set -e` to exit on errors
3. **Add documentation**: Include usage information in comments
4. **Test locally**: Verify scripts work before committing
5. **Follow conventions**: Use consistent naming and formatting

## Best Practices

1. **Use absolute paths**: When referencing files or directories
2. **Validate inputs**: Check for required parameters and conditions
3. **Provide feedback**: Use clear output messages
4. **Handle errors**: Fail gracefully with informative messages
5. **Document thoroughly**: Include examples and usage instructions
