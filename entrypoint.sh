#!/bin/sh

wiki_repo="https://${INPUT_WIKI_TOKEN}@github.com/${GITHUB_REPOSITORY}.wiki.git"

# Set git user settings (this is needed to commit and push):
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

echo "=> Cloning wiki repository ..."
git clone $wiki_repo "${GITHUB_WORKSPACE}/wiki_repo"

echo "=> Change directory into $(GITHUB_WORKSPACE)"
cd $(GITHUB_WORKSPACE)

echo "=> Updating markdown files"
find wiki_repo -type f -name "*.md" -exec md-inc {} \;

echo "=> Change directory into $(GITHUB_WORKSPACE)/wiki_repo"
cd $(GITHUB_WORKSPACE)/wiki_repo

git add .

if git commit -m"Update markdown files with repo changes"; then
    echo "=> Pushing artifacts ..."
    git push
else
    echo "(i) Nothing changed since previous build. The wiki is already up to date and therefore nothing is being pushed."
fi

# Print success message:
echo "=> Done."
echo "---"
