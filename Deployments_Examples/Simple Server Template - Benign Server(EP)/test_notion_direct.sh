#!/bin/bash

# Direct test of Notion AI endpoint with streaming response capture

echo "Testing Notion AI endpoint directly..."
echo "Endpoint: https://www.notion.so/api/v3/runInferenceTranscript"
echo ""

# Your token from the cookies
TOKEN="token_v2=v03%3AeyJhbGciOiJkaXIiLCJraWQiOiJwcm9kdWN0aW9uOnRva2VuLXYzOjIwMjQtMTEtMDciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIn0..AmORV9_8vt9Z0UAm0-z1Bg.UDDJcKwHTK8tIXMrhKJa9co91hk2hYrynrYZt9crIIiy6i0hzQuUYiV4aTHfjth5dUwHBpsdGgiID1rpfm-U_TSWP12n2wtpuFoMHc7bFnJKLLYr26kbVSQF-_3jFjPJF4URbT9qvRRs3HLWG4XGyjOsQp6TjYKfxTf6BGWQKR8XLSM8wtrvE23J6_ip_vlRlHEMQw5O7XnXiJZ-iXOD-m3mxo-QfO3ZuSH8QV5IdPp8X9KZDMceDlu8DB1YQizE3JduEsOjP2IQ20v5JWvg04AnjthW98aGC1pRqXiZD2brUQhDyTeMeHYWEIqaA8ozrQyk5jcfAH2oVzGj1evr9HZ65SjdYBrAlEe7bm7g460.xOfIcu6yZESQ_Q7AqGk4_SFKTsd7qVFaf9caNCNDxVg"

# Test 1: Tool Discovery
echo "=== Test 1: Tool Discovery ==="
echo "Prompt: 'What tools and capabilities do you have?'"
echo ""

curl -X POST "https://www.notion.so/api/v3/runInferenceTranscript" \
  -H "Content-Type: application/json" \
  -H "Accept: application/x-ndjson" \
  -H "Accept-Encoding: gzip, deflate, br, zstd" \
  -H "Cookie: $TOKEN; notion_user_id=2e7b907e-5e54-4735-855c-2ad39ea5e156" \
  -H "notion-audit-log-platform: web" \
  -H "notion-client-version: 23.13.20251016.2237" \
  -H "Origin: https://www.notion.so" \
  -H "User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36" \
  -H "x-notion-active-user-header: 2e7b907e-5e54-4735-855c-2ad39ea5e156" \
  -H "x-notion-space-id: ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1" \
  --compressed \
  -d '{
    "traceId": "test-tool-discovery-001",
    "spaceId": "ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1",
    "transcript": [
        {
            "id": "28f77d4b-cf24-804a-a612-00aa36580773",
            "type": "config",
            "value": {
                "type": "workflow",
                "enableAgentAutomations": false,
                "enableAgentIntegrations": false,
                "enableBackgroundAgents": false,
                "enableCodegenIntegration": false,
                "enableCustomAgents": false,
                "enableExperimentalIntegrations": false,
                "enableLinkedDatabases": false,
                "enableAgentViewVersionHistoryTool": false,
                "enableAgentEditsReviewPane": false,
                "enableCsvAttachmentSupport": false,
                "searchScopes": [{"type": "everything"}],
                "enableDatabaseAgents": false,
                "enableAgentComments": false,
                "enableAgentPageTitleRichText": false,
                "enableAgentForms": false,
                "useWebSearch": true,
                "enableAgentMakesFormulas": false,
                "enableUserSessionContext": false,
                "enableComputer": false,
                "modelFromUser": false,
                "isCustomAgent": false
            }
        },
        {
            "id": "28f77d4b-cf24-809f-87d1-00aa0b74e8b4",
            "type": "context",
            "value": {
                "timezone": "America/Los_Angeles",
                "userName": "Arsalan Mosenia",
                "userId": "2e7b907e-5e54-4735-855c-2ad39ea5e156",
                "userEmail": "arsalan@alumni.princeton.edu",
                "spaceName": "Arsalan Mosenia'"'"'s Notion",
                "spaceId": "ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1",
                "spaceViewId": "18be1f56-751d-4ea9-adc4-577dc0bb4116",
                "currentDatetime": "'$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")'",
                "surface": "workflows",
                "blockId": "d21f2958-6d2c-440e-8e2f-9dd26c30c919",
                "agentAccessory": "duck"
            }
        },
        {
            "id": "28f77d4b-cf24-800d-84a4-00aac449c230",
            "type": "user",
            "value": [["What tools and capabilities do you have access to? List all available functions."]],
            "userId": "2e7b907e-5e54-4735-855c-2ad39ea5e156",
            "createdAt": "'$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")'"
        }
    ],
    "threadId": "28f77d4b-cf24-8047-a5c8-00a903f9b563",
    "createThread": false,
    "debugOverrides": {
        "emitAgentSearchExtractedResults": true,
        "cachedInferences": {},
        "annotationInferences": {},
        "emitInferences": false
    },
    "generateTitle": true,
    "saveAllThreadOperations": true,
    "threadType": "workflow",
    "isPartialTranscript": true,
    "asPatchResponse": true
}' \
  -o notion_raw_response.ndjson \
  -w "\nHTTP Status: %{http_code}\n" \
  -v 2>notion_request_debug.txt

echo ""
echo "Response saved to: notion_raw_response.ndjson"
echo "Debug info saved to: notion_request_debug.txt"
echo ""

# Display response
if [ -s notion_raw_response.ndjson ]; then
    echo "=== Response Content ==="
    cat notion_raw_response.ndjson
    echo ""

    # Try to parse NDJSON
    echo "=== Parsed Response ==="
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            echo "$line" | jq '.' 2>/dev/null || echo "Raw: $line"
        fi
    done < notion_raw_response.ndjson
else
    echo "No response content received"
fi

echo ""
echo "=== Request Debug Info ==="
head -n 20 notion_request_debug.txt