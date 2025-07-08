#!/bin/bash -e


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$SCRIPT_DIR" )"


echo "Enter the new Helm chart version:"
read new_version

new_version=${new_version#v}
tag="v$new_version"

# Validate the version with the user
echo "Is version $new_version correct? (y/n)"
read confirmation
if [ "$confirmation" != "y" ] && [ "$confirmation" != "Y" ]; then
    echo "Version update cancelled."
    exit 1
fi

git reset

# Use a temporary file for sed replacement to ensure compatibility with BSD sed on macOS
sed "s/version: .*/version: $new_version/" "$PROJECT_ROOT/Chart.yaml" > "$PROJECT_ROOT/Chart.yaml.tmp"
mv "$PROJECT_ROOT/Chart.yaml.tmp" "$PROJECT_ROOT/Chart.yaml"

git add "$PROJECT_ROOT/Chart.yaml"
git commit -m "chore: update helm chart version to $new_version"
git tag "$tag"
git push origin "$tag"
git push origin HEAD

echo "Version updated to $new_version, committed, tagged, and pushed successfully."
