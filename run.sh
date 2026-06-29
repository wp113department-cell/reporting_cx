#!/bin/bash

echo ""
echo "================================================"
echo "   Daily Work Update Generator"
echo "================================================"
echo ""

# Check Python
if ! command -v python3 &>/dev/null; then
    echo "❌ Python3 not found. Please install Python 3.8+"
    exit 1
fi

# Create venv if not exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate

# Install / update dependencies
echo "📦 Installing dependencies..."
pip install -r requirements.txt -q --upgrade

echo ""

# Check for credentials.json (Google Drive)
if [ ! -f "credentials.json" ]; then
    echo "⚠️  WARNING: credentials.json not found!"
    echo ""
    echo "   To enable Google Drive saving, follow these steps:"
    echo ""
    echo "   1. Go to: https://console.cloud.google.com"
    echo "   2. Create a new project (or select existing)"
    echo "   3. Enable 'Google Drive API'"
    echo "   4. Go to Credentials → Create Credentials → OAuth 2.0 Client ID"
    echo "   5. Application type: Desktop App"
    echo "   6. Download the JSON and rename it to: credentials.json"
    echo "   7. Place credentials.json in this folder: $(pwd)"
    echo "   8. On first run, a browser will open — log in with your WORK Google account"
    echo ""
    echo "   (App will still run — Drive saving will show an error until credentials.json is added)"
    echo ""
fi

# Check Gmail config
if grep -q "your_gmail" .env 2>/dev/null || ! grep -q "GMAIL_USER=." .env 2>/dev/null; then
    echo "ℹ️  NOTE: Gmail not configured yet."
    echo "   Edit .env and add:"
    echo "     GMAIL_USER=your_work_email@gmail.com"
    echo "     GMAIL_APP_PASSWORD=your_app_password"
    echo ""
    echo "   To get App Password:"
    echo "   myaccount.google.com → Security → 2-Step Verification → App Passwords"
    echo ""
fi

echo "✅ Ready!"
echo "🌐 Opening at: http://localhost:5000"
echo "🛑 Press Ctrl+C to stop"
echo ""

python3 app.py
