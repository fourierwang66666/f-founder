#!/usr/bin/env bash
# reddit-profile.sh — Fetch Reddit posts and comments for persona building
#
# Usage:
#   reddit-profile.sh <subreddit> [query] [--limit N] [--time day|week|month]
#
# Requires: reddit-readonly skill (node + reddit-readonly.mjs)
#
# Output: JSON with posts and top comments, suitable for persona construction.

set -euo pipefail

SUBREDDIT="${1:?Usage: reddit-profile.sh <subreddit> [query] [--limit N] [--time day|week|month]}"
shift
QUERY=""
LIMIT=15
TIME="month"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --limit) LIMIT="$2"; shift 2 ;;
    --time)  TIME="$2";  shift 2 ;;
    *)       [[ -z "$QUERY" ]] && QUERY="$1"; shift ;;
  esac
done

# Find reddit-readonly script
REDDIT_SCRIPT=""
for dir in \
  "${SKILL_DIR:-/nonexistent}/../../reddit-readonly/scripts" \
  "${HOME}/.openclaw/skills/reddit-readonly/scripts" \
  "$(dirname "$0")/../../reddit-readonly/scripts"; do
  if [[ -f "${dir}/reddit-readonly.mjs" ]]; then
    REDDIT_SCRIPT="${dir}/reddit-readonly.mjs"
    break
  fi
done

# Fallback: search workspace skills
if [[ -z "$REDDIT_SCRIPT" ]]; then
  FOUND=$(find "${WORKSPACE_DIR:-$HOME}" -name "reddit-readonly.mjs" -path "*/scripts/*" 2>/dev/null | head -1 || true)
  if [[ -n "$FOUND" ]]; then
    REDDIT_SCRIPT="$FOUND"
  fi
fi

if [[ -z "$REDDIT_SCRIPT" ]]; then
  echo '{"ok":false,"error":"reddit-readonly.mjs not found. Install reddit-readonly skill."}' >&2
  exit 1
fi

TMPDIR_WORK=$(mktemp -d)
trap 'rm -rf "$TMPDIR_WORK"' EXIT

# Fetch posts
echo "Fetching from r/${SUBREDDIT}..." >&2
if [[ -n "$QUERY" ]]; then
  node "$REDDIT_SCRIPT" search "$SUBREDDIT" "$QUERY" --limit "$LIMIT" \
    > "$TMPDIR_WORK/posts.json" 2>/dev/null || echo '{"ok":false}' > "$TMPDIR_WORK/posts.json"
else
  node "$REDDIT_SCRIPT" posts "$SUBREDDIT" --sort top --time "$TIME" --limit "$LIMIT" \
    > "$TMPDIR_WORK/posts.json" 2>/dev/null || echo '{"ok":false}' > "$TMPDIR_WORK/posts.json"
fi

# Fetch recent comments for richer persona data
node "$REDDIT_SCRIPT" recent-comments "$SUBREDDIT" --limit 25 \
  > "$TMPDIR_WORK/comments.json" 2>/dev/null || echo '{"ok":false}' > "$TMPDIR_WORK/comments.json"

# Combine output
python3 - "$TMPDIR_WORK/posts.json" "$TMPDIR_WORK/comments.json" "$SUBREDDIT" "$QUERY" <<'PYEOF'
import json, sys

posts_file, comments_file, subreddit, query = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]

with open(posts_file) as f:
    posts = json.load(f)
with open(comments_file) as f:
    comments = json.load(f)

result = {
    "subreddit": subreddit,
    "query": query if query else None,
    "posts": posts.get("data", []) if posts.get("ok") else [],
    "comments": comments.get("data", []) if comments.get("ok") else [],
    "post_count": len(posts.get("data", [])) if posts.get("ok") else 0,
    "comment_count": len(comments.get("data", [])) if comments.get("ok") else 0,
}

json.dump(result, sys.stdout, ensure_ascii=False, indent=2)
PYEOF
