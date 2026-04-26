#!/bin/bash
# Helper script to generate a Stitch screen and download assets
# Usage: ./generate_screen.sh <screen-name> <prompt>

SCREEN_NAME="$1"
PROMPT="$2"
PROJECT_ID="3823020204310937544"
GCP_PROJECT="khatamitra-492302"
OUTPUT_DIR="/Users/C5404787/workplace/personal/khata_pro/.stitch/designs/${SCREEN_NAME}"

mkdir -p "$OUTPUT_DIR"

GCLOUD_TOKEN=$(CLOUDSDK_PYTHON_SITEPACKAGES=1 PYTHONWARNINGS=ignore /Users/C5404787/google-cloud-sdk/bin/gcloud auth application-default print-access-token 2>/dev/null)

echo "Generating screen: $SCREEN_NAME"

RESPONSE=$(curl -s -X POST "https://stitch.googleapis.com/mcp" \
  -H "Authorization: Bearer $GCLOUD_TOKEN" \
  -H "X-Goog-User-Project: $GCP_PROJECT" \
  -H "Content-Type: application/json" \
  --max-time 180 \
  -d "{\"jsonrpc\":\"2.0\",\"method\":\"tools/call\",\"params\":{\"name\":\"generate_screen_from_text\",\"arguments\":{\"projectId\":\"${PROJECT_ID}\",\"prompt\":$(echo "$PROMPT" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))'),\"deviceType\":\"MOBILE\"}},\"id\":1}")

echo "$RESPONSE" > "${OUTPUT_DIR}/response.json"

# Extract screen ID and download URLs
echo "$RESPONSE" | python3 -c "
import sys, json, re

raw = sys.stdin.read()
try:
    outer = json.loads(raw)
    content = outer.get('result',{}).get('content',[])
    screen_id = None
    download_url = None
    screenshot_url = None

    for item in content:
        text = item.get('text','')
        # Try parsing as JSON
        try:
            data = json.loads(text)
            # Look for screen data
            if 'name' in data and 'screens/' in str(data.get('name','')):
                screen_id = data['name'].split('/')[-1]
                print(f'SCREEN_ID={screen_id}')
            # Look for download URLs in the whole structure
            def find_urls(obj, path=''):
                if isinstance(obj, dict):
                    for k,v in obj.items():
                        find_urls(v, path+'.'+k)
                        if k == 'downloadUrl' and isinstance(v,str):
                            if '.html' in v or 'code' in path.lower():
                                print(f'CODE_URL={v}')
                            elif '.png' in v or 'screenshot' in path.lower() or 'image' in path.lower():
                                print(f'IMG_URL={v}')
                elif isinstance(obj, list):
                    for i,v in enumerate(obj):
                        find_urls(v, path+f'[{i}]')
            find_urls(data)
        except:
            pass
        # Regex fallback
        ids = re.findall(r'screens/([a-f0-9]{32})', text)
        if ids:
            print(f'SCREEN_ID={ids[0]}')
        html_urls = re.findall(r'https://[^\s\"]+\.html[^\s\"]*', text)
        for u in html_urls:
            print(f'CODE_URL={u}')
        png_urls = re.findall(r'https://lh3\.googleusercontent\.com/[^\s\"]+', text)
        for u in png_urls[:1]:
            print(f'IMG_URL={u}')
except Exception as e:
    print(f'ERROR={e}')
    print(raw[:500])
"
