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
