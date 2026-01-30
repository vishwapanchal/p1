import sys
import os

# allow import from backend folder
sys.path.append(os.path.join(os.path.dirname(__file__), ".."))

from backend.app.main import app
