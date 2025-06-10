#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean assets
rm -rf public/assets

# Build assets
bundle exec rails assets:precompile

# Build JavaScript
bundle exec rails javascript:build

# Create database if it doesn't exist
bundle exec rails db:create

# Run migrations
bundle exec rails db:migrate

# Clean old logs and tempfiles
bundle exec rails log:clear tmp:clear 