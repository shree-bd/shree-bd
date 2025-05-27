#!/bin/bash

# GitHub Profile Setup Script
# This script helps set up your advanced GitHub profile

echo "🚀 Setting up your advanced GitHub profile..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git first."
    exit 1
fi

print_status "Git is installed"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_warning "Not in a git repository. Initializing..."
    git init
    print_status "Git repository initialized"
fi

# Create necessary directories
mkdir -p .github/workflows
mkdir -p assets

print_status "Created necessary directories"

# Check if README.md exists and backup if needed
if [ -f "README.md" ]; then
    print_warning "README.md already exists. Creating backup..."
    cp README.md README.md.backup
    print_status "Backup created as README.md.backup"
fi

# Get GitHub username
echo ""
print_info "Please enter your GitHub username:"
read -p "Username: " github_username

if [ -z "$github_username" ]; then
    print_error "GitHub username is required!"
    exit 1
fi

# Update README.md with the correct username
if [ -f "README.md" ]; then
    # Replace placeholder username with actual username
    sed -i.bak "s/shree-bd/$github_username/g" README.md
    rm README.md.bak 2>/dev/null
    print_status "Updated README.md with your username: $github_username"
fi

# Set up git configuration if not already set
if [ -z "$(git config user.name)" ]; then
    echo ""
    print_info "Please enter your full name for git configuration:"
    read -p "Full Name: " full_name
    git config user.name "$full_name"
    print_status "Git user name configured"
fi

if [ -z "$(git config user.email)" ]; then
    echo ""
    print_info "Please enter your email for git configuration:"
    read -p "Email: " email
    git config user.email "$email"
    print_status "Git user email configured"
fi

# Add all files to git
git add .

# Commit changes
git commit -m "🚀 Set up advanced GitHub profile with analytics and animations"

print_status "Changes committed to git"

# Instructions for GitHub setup
echo ""
echo "🎉 Setup complete! Here's what you need to do next:"
echo ""
print_info "1. Create a new repository on GitHub with the name: $github_username"
print_info "2. Make sure the repository is public"
print_info "3. Push your changes to GitHub:"
echo "   git remote add origin https://github.com/$github_username/$github_username.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
print_info "4. Enable GitHub Actions in your repository settings"
print_info "5. The workflow will automatically update your README every 6 hours"
echo ""
print_warning "Optional enhancements:"
echo "   • Set up Wakatime for coding time tracking"
echo "   • Add your best repositories to the featured section"
echo "   • Customize the goals and objectives section"
echo "   • Update your contact information and social links"
echo ""
print_status "Your GitHub profile is now ready to impress! 🌟"

# Check if the user wants to open the README
echo ""
read -p "Would you like to preview the README.md file? (y/n): " preview_choice

if [[ $preview_choice =~ ^[Yy]$ ]]; then
    if command -v code &> /dev/null; then
        code README.md
        print_status "Opened README.md in VS Code"
    elif command -v nano &> /dev/null; then
        nano README.md
    elif command -v vim &> /dev/null; then
        vim README.md
    else
        cat README.md
    fi
fi

echo ""
print_status "Setup script completed successfully! 🎊" 