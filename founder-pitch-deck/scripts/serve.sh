#!/usr/bin/env bash
# Local preview server for pitch deck
# Usage: serve.sh [directory] [port]

DIR="${1:-.}"
PORT="${2:-8080}"

cd "$DIR" || exit 1

echo "Serving pitch deck at http://localhost:$PORT"
echo "Press Ctrl+C to stop"

if command -v python3 &>/dev/null; then
  python3 -m http.server "$PORT"
elif command -v python &>/dev/null; then
  python -m http.server "$PORT"
else
  echo "Error: Python not found. Install Python 3 or open index.html directly in your browser."
  exit 1
fi
