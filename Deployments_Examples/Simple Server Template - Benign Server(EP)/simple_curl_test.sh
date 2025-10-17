#!/bin/bash

echo "Testing simple curl with cookies file..."

# Save cookies to a file
cat > cookies.txt << 'EOF'
# Netscape HTTP Cookie File
.notion.so	TRUE	/	TRUE	0	token_v2	v03%3AeyJhbGciOiJkaXIiLCJraWQiOiJwcm9kdWN0aW9uOnRva2VuLXYzOjIwMjQtMTEtMDciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIn0..AmORV9_8vt9Z0UAm0-z1Bg.UDDJcKwHTK8tIXMrhKJa9co91hk2hYrynrYZt9crIIiy6i0hzQuUYiV4aTHfjth5dUwHBpsdGgiID1rpfm-U_TSWP12n2wtpuFoMHc7bFnJKLLYr26kbVSQF-_3jFjPJF4URbT9qvRRs3HLWG4XGyjOsQp6TjYKfxTf6BGWQKR8XLSM8wtrvE23J6_ip_vlRlHEMQw5O7XnXiJZ-iXOD-m3mxo-QfO3ZuSH8QV5IdPp8X9KZDMceDlu8DB1YQizE3JduEsOjP2IQ20v5JWvg04AnjthW98aGC1pRqXiZD2brUQhDyTeMeHYWEIqaA8ozrQyk5jcfAH2oVzGj1evr9HZ65SjdYBrAlEe7bm7g460.xOfIcu6yZESQ_Q7AqGk4_SFKTsd7qVFaf9caNCNDxVg
.notion.so	TRUE	/	TRUE	0	notion_user_id	2e7b907e-5e54-4735-855c-2ad39ea5e156
EOF

# Simple payload
PAYLOAD='{
  "traceId": "simple-test-001",
  "spaceId": "ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1",
  "transcript": [{
    "type": "user",
    "value": [["What tools do you have?"]],
    "userId": "2e7b907e-5e54-4735-855c-2ad39ea5e156"
  }],
  "threadId": "28f77d4b-cf24-8047-a5c8-00a903f9b563",
  "threadType": "workflow",
  "isPartialTranscript": true,
  "asPatchResponse": true
}'

echo "Sending test request..."
curl -v 'https://www.notion.so/api/v3/runInferenceTranscript' \
  -H 'content-type: application/json' \
  -H 'accept: application/x-ndjson' \
  -H 'x-notion-active-user-header: 2e7b907e-5e54-4735-855c-2ad39ea5e156' \
  -b cookies.txt \
  -d "$PAYLOAD" \
  -o test_response.txt 2>test_debug.txt

echo ""
echo "Response size: $(wc -c < test_response.txt) bytes"
echo ""
echo "Debug output:"
grep -E "< HTTP|< content-|401|403|200" test_debug.txt

echo ""
echo "Response content (first 500 chars):"
head -c 500 test_response.txt