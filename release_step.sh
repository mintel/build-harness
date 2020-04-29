#!/usr/bin/env bash

# Check the CHANGELOG
# Use awk to check the number of non-header lines with stuff in them
awk '/^## \[U/,/^## \[[0-9]/' CHANGELOG.md | awk '!/^## \[/ {total += NF} END {exit !total}'
if [ $? -ne 0 ]; then
    echo 'bump changelog failure: nothing added to [Unreleased Section]'
    exit 1
fi

# Check bumpversion & parse the new version number using awk
set -eo pipefail
new_version="$(bumpversion $1 --dry-run --list | awk -F'=' '/new_version/ {print $2}')"

# Do the bump, update the changelog using sed
sed -i 's/## \[Unreleased\]/## \[Unreleased\]\n\n\n## \['$new_version'\] - '$(date +%Y-%m-%d)'/g' CHANGELOG.md
git commit -am "bump CHANGELOG to $new_version"
bumpversion $1 --verbose

