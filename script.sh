#!/bin/bash

# 1. Revert api/index.py to the previous version
cat << 'EOF' > api/index.py
import sys, os
sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

from backend.app.main import app

# Vercel expects variable named "handler"
handler = app
EOF

# 2. Revert vercel.json to use 'routes' instead of 'rewrites'
cat << 'EOF' > vercel.json
{
  "routes": [
    { "src": "/api/(.*)", "dest": "api/index.py" }
  ]
}
EOF

# 3. Clean up the root requirements.txt if you wish to keep it only in the backend folder
# Uncomment the line below if you want to remove the root-level requirements file
# rm requirements.txt

echo "✅ Files have been reverted to their previous state."