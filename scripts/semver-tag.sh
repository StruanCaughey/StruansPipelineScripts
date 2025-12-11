#!/bin/bash

# Semantic Version Tagging Script
# This script automatically determines and creates semantic version tags based on commit history

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to get the latest tag
get_latest_tag() {
    git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"
}

# Function to determine bump type from commits
determine_bump_type() {
    local latest_tag=$1
    local commits
    
    if [[ "$latest_tag" == "v0.0.0" ]]; then
        commits=$(git log --pretty=format:"%s")
    else
        commits=$(git log ${latest_tag}..HEAD --pretty=format:"%s")
    fi
    
    if echo "$commits" | grep -qE "BREAKING CHANGE|^feat!:|^fix!:"; then
        echo "major"
    elif echo "$commits" | grep -qE "^feat:"; then
        echo "minor"
    elif echo "$commits" | grep -qE "^fix:"; then
        echo "patch"
    else
        echo "patch"
    fi
}

# Function to calculate new version
calculate_new_version() {
    local current_version=$1
    local bump_type=$2
    
    # Remove 'v' prefix if present
    current_version=${current_version#v}
    
    # Split version into components
    IFS='.' read -ra version_parts <<< "$current_version"
    local major=${version_parts[0]}
    local minor=${version_parts[1]}
    local patch=${version_parts[2]}
    
    # Bump version based on type
    case $bump_type in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
    esac
    
    echo "v${major}.${minor}.${patch}"
}

# Main script
main() {
    print_info "Semantic Version Tagging Script"
    echo ""
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository"
        exit 1
    fi
    
    # Get latest tag
    latest_tag=$(get_latest_tag)
    print_info "Latest tag: $latest_tag"
    
    # Determine bump type
    bump_type=${1:-auto}
    
    if [[ "$bump_type" == "auto" ]]; then
        bump_type=$(determine_bump_type "$latest_tag")
        print_info "Auto-determined bump type: $bump_type"
    else
        print_info "Manual bump type: $bump_type"
    fi
    
    # Calculate new version
    new_version=$(calculate_new_version "$latest_tag" "$bump_type")
    print_info "New version: $new_version"
    
    # Check if tag already exists
    if git rev-parse "$new_version" >/dev/null 2>&1; then
        print_error "Tag $new_version already exists"
        exit 1
    fi
    
    # Confirm with user
    echo ""
    read -p "Create tag $new_version? (y/N) " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Create and push tag
        git tag -a "$new_version" -m "Release $new_version"
        print_info "Tag created: $new_version"
        
        read -p "Push tag to remote? (y/N) " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git push origin "$new_version"
            print_info "Tag pushed to remote"
        fi
    else
        print_warning "Tag creation cancelled"
    fi
}

# Run main function
main "$@"
