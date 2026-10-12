#!/usr/bin/env bash
set -euo pipefail

# deploy.sh
# Packages and deploys VanGoghFlow.github.io static portfolio website
# (index.html, assets/, README.md, etc.) directly into a local 'gh-pages' branch
# using git plumbing, without dirtying your working tree.
#
# Usage:
#   ./deploy.sh                  # Commit site directly to local gh-pages branch
#   ./deploy.sh --push           # Commit and push gh-pages branch to origin
#   ./deploy.sh -m "Custom msg"  # Specify a custom commit message
#   ./deploy.sh --orphan         # Create a clean orphan commit with no history

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || pwd)"

BRANCH="gh-pages"
DO_PUSH=false
ORPHAN=false
CUSTOM_MSG=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--push)
            DO_PUSH=true
            shift
            ;;
        -b|--branch)
            BRANCH="$2"
            shift 2
            ;;
        -m|--message)
            CUSTOM_MSG="$2"
            shift 2
            ;;
        -o|--orphan)
            ORPHAN=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  -p, --push            Push target branch to remote 'origin' after committing"
            echo "  -b, --branch <name>   Target deployment branch (default: gh-pages)"
            echo "  -m, --message <msg>   Custom commit message"
            echo "  -o, --orphan          Create fresh orphan commit without parent commit history"
            echo "  -h, --help            Show this help dialog"
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Run '$0 --help' for usage." >&2
            exit 1
            ;;
    esac
done

if [ ! -f "$REPO_ROOT/index.html" ]; then
    echo "Error: index.html not found in repository root ($REPO_ROOT)." >&2
    exit 1
fi

echo "Packaging Van Gogh Flow portfolio into branch '$BRANCH'..."

# Create isolated temporary staging directory and independent git index
TMP_DIR=$(mktemp -d)
INDEX_FILE=$(mktemp -u)

cleanup() {
    rm -rf "$TMP_DIR"
    rm -f "$INDEX_FILE"
}
trap cleanup EXIT

# Copy web files to temporary directory
cp "$REPO_ROOT/index.html" "$TMP_DIR/"
[ -f "$REPO_ROOT/README.md" ] && cp "$REPO_ROOT/README.md" "$TMP_DIR/"

if [ -d "$REPO_ROOT/assets" ]; then
    cp -R "$REPO_ROOT/assets" "$TMP_DIR/"
fi

# Ensure GitHub Pages Jekyll bypass marker exists
touch "$TMP_DIR/.nojekyll"

# Remove system artifacts
find "$TMP_DIR" -name ".DS_Store" -delete 2>/dev/null || true

# Prepare git plumbing environment
GIT_DIR="$(git -C "$REPO_ROOT" rev-parse --absolute-git-dir)"
export GIT_DIR
export GIT_WORK_TREE="$TMP_DIR"
export GIT_INDEX_FILE="$INDEX_FILE"

git add -A -f
TREE_ID=$(git write-tree)

TIMESTAMP=$(date -u +'%Y-%m-%d %H:%M:%S UTC')
DEFAULT_MSG="Deploy Van Gogh Flow portfolio showcase ($TIMESTAMP)"
COMMIT_MSG="${CUSTOM_MSG:-$DEFAULT_MSG}"

# Determine parent commit unless orphan mode requested
COMMIT_ID=""
if [ "$ORPHAN" = false ] && git -C "$REPO_ROOT" rev-parse --verify "refs/heads/$BRANCH" >/dev/null 2>&1; then
    PARENT_COMMIT="$(git -C "$REPO_ROOT" rev-parse "refs/heads/$BRANCH")"
    PARENT_TREE="$(git -C "$REPO_ROOT" rev-parse "$PARENT_COMMIT^{tree}" 2>/dev/null || true)"
    if [ "$PARENT_TREE" = "$TREE_ID" ]; then
        echo "No changes detected in web assets since last commit ($PARENT_COMMIT)."
        COMMIT_ID="$PARENT_COMMIT"
    else
        COMMIT_ID=$(git commit-tree "$TREE_ID" -p "$PARENT_COMMIT" -m "$COMMIT_MSG")
        git -C "$REPO_ROOT" update-ref "refs/heads/$BRANCH" "$COMMIT_ID"
    fi
else
    COMMIT_ID=$(git commit-tree "$TREE_ID" -m "$COMMIT_MSG")
    git -C "$REPO_ROOT" update-ref "refs/heads/$BRANCH" "$COMMIT_ID"
fi

TOTAL_FILES=$(find "$TMP_DIR" -type f | wc -l | tr -d ' ')

echo "------------------------------------------------------------"
echo "Successfully committed static site to '$BRANCH' branch!"
echo "  Commit:       $COMMIT_ID"
echo "  Total files:  $TOTAL_FILES"
echo "  Message:      $COMMIT_MSG"
echo "------------------------------------------------------------"

if [ "$DO_PUSH" = true ]; then
    if git -C "$REPO_ROOT" remote get-url origin >/dev/null 2>&1; then
        echo "Pushing '$BRANCH' to origin..."
        git -C "$REPO_ROOT" push -u origin "$BRANCH"
        echo "Push complete!"
    else
        echo "Warning: Remote 'origin' is not configured yet." >&2
        echo "Configure remote with: git remote add origin <repo-url>" >&2
        echo "Then push with:        git push -u origin $BRANCH" >&2
    fi
else
    echo "To push this branch to GitHub:"
    echo "    git push -u origin $BRANCH"
    echo ""
    echo "GitHub Pages configuration:"
    echo "  1. In repository settings on GitHub: Settings -> Pages"
    echo "  2. Under 'Build and deployment' > 'Source': select 'Deploy from a branch'"
    echo "  3. Select branch '$BRANCH' and folder '/ (root)'"
    echo "  4. Save; GitHub Pages will deploy the static site at:"
    echo "     https://benjaminpritchard.github.io/VanGoghFlow.github.io/ (or custom domain)"
fi
