# Login into app
# !/bin/bash

API_BASE="http://api.local"

loginUrl="$API_BASE/login"
loginPayload='{
  "username": "user",
  "password": "secret"
}'

# Run curl and capture headers + body
response=$(curl -D - -o - \
  --location "$loginUrl" \
  --header 'Content-Type: application/json' \
  --data "$loginPayload")

# Extract headers (everything until first empty line)
headers=$(echo "$response" | sed -n '/^\r$/q;p')

# Extract body (everything after first empty line)
body=$(echo "$response" | sed -n -e '1,/^\r$/d' -e '1,/^$/d;p')

echo "---- Headers ----"
echo "$headers"

auth_header=$(echo "$headers" | grep -i "^app-context-token:" | cut -d' ' -f2-)

IMPORT_DIR="test_series_2_1500"
#IMPORT_DIR="test_series_3_8000"
#IMPORT_DIR="test_series_5_18500"
#IMPORT_DIR="test_series_128_192000"
PLUGIN_CODE="ACCOUNT_TRANSFERS"

for file in "$IMPORT_DIR"/*.csv; do
  echo "📂 Processing file: $file"

  # Step 1: Upload file
  upload_response=$(curl -s -X POST "$API_BASE/payments/upload" \
    -H "app-context-token: $auth_header" \
    -F "file=@$file")

  echo "Upload response: $upload_response"

  # Extract UUID (string literal JSON)
  fileId=$(echo "$upload_response" | tr -d '"')

  if [[ -z "$fileId" ]]; then
    echo "❌ Upload failed for $file (no UUID returned)"
    continue
  fi

  echo "✅ Uploaded, got fileId: $fileId"

  # Step 2: Start import
  start_response=$(curl -s -X POST \
    "$API_BASE/payments/import/start/$fileId/$PLUGIN_CODE" \
    -H "app-context-token: $auth_header")

  echo "Import response: $start_response"
done
