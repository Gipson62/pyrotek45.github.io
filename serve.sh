#!/usr/bin/env bash
# Watches for changes and rebuilds, then serves on localhost:8000

set -e

PORT=${1:-8000}
SITE_DIR="$(pwd)/_site"

# Initial build
echo "📦 Building site..."
bash ./build.sh

# Function to run server in background
run_server() {
    cd "$SITE_DIR"
    echo "🚀 Server running at http://localhost:$PORT"
    echo "Press Ctrl+C to stop"
    python3 -m http.server "$PORT"
}

# Watch for changes and rebuild
if command -v watchexec >/dev/null 2>&1; then
    echo "👀 Watching for changes with watchexec..."
    watchexec -r -c -e md,av,scss,html './build.sh && echo "✅ Rebuilt at $(date +%H:%M:%S)"'
else
    echo "⚠️  watchexec not found. Falling back to polling (2s interval)."
    echo "   (Install watchexec or use 'nix-shell' for better performance)"
    
    while true; do
        sleep 2
        # Check if any source file is newer than the build output
        # We check common source extensions
        CHANGED=$(find . -maxdepth 4 -type f \( -name "*.md" -o -name "*.av" -o -name "*.scss" -o -name "*.html" \) -not -path "./_site/*" -newer "$SITE_DIR/index.html" 2>/dev/null | head -n 1)
        
        if [ -n "$CHANGED" ]; then
            echo "🔄 Detected change in $CHANGED"
            ./build.sh
            echo "✅ Rebuilt at $(date +%H:%M:%S)"
        fi
    done
fi

# Clean up on exit
trap "kill $SERVER_PID 2>/dev/null || true" EXIT
