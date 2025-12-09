#!/usr/bin/env bash
set -e

echo "📦 Building site..."
rm -rf _site
./build.sh

echo "🚀 Deploying to gh-pages branch..."

# Go to build directory
cd _site

# Initialize a new git repo
git init
git checkout -b gh-pages

# Add all files
git add .

# Commit
git commit -m "Deploy: $(date)"

# Push to the gh-pages branch of the origin repository
# We assume the parent directory has the correct remote 'origin'
REMOTE_URL=$(git -C .. config --get remote.origin.url)

if [ -z "$REMOTE_URL" ]; then
    echo "❌ Error: Could not find remote 'origin' in parent directory."
    exit 1
fi

echo "Pushing to $REMOTE_URL..."
git push -f "$REMOTE_URL" gh-pages

echo "✅ Deployed successfully!"
