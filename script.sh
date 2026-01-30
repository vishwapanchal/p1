#!/bin/bash

# 1. Update api/index.py with robust path resolution
# This ensures Vercel can find the 'backend' folder regardless of execution context
cat << 'EOF' > api/index.py
import sys
import os

# Add the project root to sys.path
# This allows 'from backend.app.main import app' to work correctly
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(current_dir)
sys.path.append(project_root)

try:
    from backend.app.main import app
    # Vercel's Python runtime requires a 'handler' variable
    handler = app
except ImportError as e:
    print(f"Import Error: {e}")
    raise e
EOF

# 2. Update vercel.json to ensure correct routing
# Using 'rewrites' is often more reliable than 'routes' in newer Vercel versions
cat << 'EOF' > vercel.json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "api/index.py"
    }
  ]
}
EOF

# 3. Consolidate requirements
# Vercel looks for requirements.txt in the root directory
cp backend/requirements.txt ./requirements.txt

echo "✅ Fixes applied: api/index.py updated, vercel.json rewritten, and requirements.txt synced."