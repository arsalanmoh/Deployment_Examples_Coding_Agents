#!/bin/bash

echo "Testing with exact working curl format..."

# Test 1: Tool Discovery
curl -s 'https://www.notion.so/api/v3/runInferenceTranscript' \
  -H 'accept: application/x-ndjson' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'content-type: application/json' \
  -b '_hjSessionUser_3664679=eyJpZCI6IjZmNThkNDE3LTkxNDUtNWZlMS04MjFlLWQ1NmE1NDQ4MzMwNSIsImNyZWF0ZWQiOjE3NDQzMDc2MjMzNDYsImV4aXN0aW5nIjp0cnVlfQ==; notion_browser_id=78f9ec02-2550-48d9-8f7e-962f9e87b198; device_id=26cd872b-594c-8141-8035-003be20fdd8c; _gcl_au=1.1.1955020961.1757714315; _ga=GA1.1.1167000869.1757714316; _rdt_uuid=1757714316761.2578aecf-b4fd-4f2a-beb5-ff03dfe16ed9; _fbp=fb.1.1757714338258.848893213512006558; notion_user_id=2e7b907e-5e54-4735-855c-2ad39ea5e156; NEXT_LOCALE=en-US; p_sync_session=%7B%22tokenId%22%3A%22v02%3Async_session%3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf38tiE-sIRdO2rwW24nfZ7u9h-MytbYGKknbSPCj2F07ufgzySFKfcgMeq_zLYqJ2Sxhhjv8ncaGkc0y2t0bTCjWjJ7t07goOQVt%22%2C%22userIds%22%3A%5B%222e7b907e-5e54-4735-855c-2ad39ea5e156%22%5D%7D; _cioid=2e7b907e5e544735855c2ad39ea5e156; notion_locale=en-US/autodetect; notion_cookie_sync_completed=%7B%22completed%22%3Atrue%2C%22version%22%3A4%2C%22attempts%22%3A0%7D; notion_users=[%222e7b907e-5e54-4735-855c-2ad39ea5e156%22]; ajs_anonymous_id=%22206c57c9-20cc-41ab-a71b-c886930eef4b%22; notion_check_cookie_consent=false; token_v2=v03%3AeyJhbGciOiJkaXIiLCJraWQiOiJwcm9kdWN0aW9uOnRva2VuLXYzOjIwMjQtMTEtMDciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIn0..AmORV9_8vt9Z0UAm0-z1Bg.UDDJcKwHTK8tIXMrhKJa9co91hk2hYrynrYZt9crIIiy6i0hzQuUYiV4aTHfjth5dUwHBpsdGgiID1rpfm-U_TSWP12n2wtpuFoMHc7bFnJKLLYr26kbVSQF-_3jFjPJF4URbT9qvRRs3HLWG4XGyjOsQp6TjYKfxTf6BGWQKR8XLSM8wtrvE23J6_ip_vlRlHEMQw5O7XnXiJZ-iXOD-m3mxo-QfO3ZuSH8QV5IdPp8X9KZDMceDlu8DB1YQizE3JduEsOjP2IQ20v5JWvg04AnjthW98aGC1pRqXiZD2brUQhDyTeMeHYWEIqaA8ozrQyk5jcfAH2oVzGj1evr9HZ65SjdYBrAlEe7bm7g460.xOfIcu6yZESQ_Q7AqGk4_SFKTsd7qVFaf9caNCNDxVg; _ga_9ZJ8CB186L=GS2.1.s1760664919$o8$g1$t1760666087$j60$l0$h0; __cf_bm=06CODGNMOAuP6D2FNHh5njp50EwJ2vfd0NDtpYqxqM0-1760666866-1.0.1.1-dWbG4XMPIH7qIA3XQUbxmZcIz00s_RcM61xzULyVFhk_DoGhS1a6jLqEsJE2jC4kIlXDl4JGqBSVsD1LUpd66ytd1Djo7qzdkAZ6LCW9oHU; _cfuvid=13lwamFYpUCQcGfY8mIOzQNkN5Q8SyTFMGKglijVsUk-1760666866972-0.0.1.1-604800000' \
  -H 'notion-audit-log-platform: web' \
  -H 'notion-client-version: 23.13.20251016.2237' \
  -H 'origin: https://www.notion.so' \
  -H 'priority: u=1, i' \
  -H 'referer: https://www.notion.so/Command-Center-d21f29586d2c440e8e2f9dd26c30c919?t=28f77d4bcf248047a5c800a903f9b563' \
  -H 'sec-ch-ua: "Google Chrome";v="141", "Not?A_Brand";v="8", "Chromium";v="141"' \
  -H 'sec-ch-ua-mobile: ?1' \
  -H 'sec-ch-ua-platform: "Android"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36' \
  -H 'x-notion-active-user-header: 2e7b907e-5e54-4735-855c-2ad39ea5e156' \
  -H 'x-notion-space-id: ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1' \
  --data-raw '{"traceId":"tool-discovery-test","spaceId":"ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1","transcript":[{"id":"28f77d4b-cf24-804a-a612-00aa36580773","type":"config","value":{"type":"workflow","model":"openai-turbo","searchScopes":[{"type":"everything"}],"useWebSearch":true,"isCustomAgent":false,"modelFromUser":false,"enableComputer":false,"enableAgentForms":false,"enableCustomAgents":false,"enableAgentComments":false,"enableDatabaseAgents":false,"enableLinkedDatabases":false,"enableAgentAutomations":false,"enableBackgroundAgents":false,"enableAgentIntegrations":false,"enableAgentMakesFormulas":false,"enableCodegenIntegration":false,"enableUserSessionContext":false,"enableAgentEditsReviewPane":false,"enableCsvAttachmentSupport":false,"enableAgentPageTitleRichText":false,"enableExperimentalIntegrations":false,"enableAgentViewVersionHistoryTool":false}},{"id":"28f77d4b-cf24-809f-87d1-00aa0b74e8b4","type":"context","value":{"timezone":"America/Los_Angeles","userName":"Arsalan Mosenia","userId":"2e7b907e-5e54-4735-855c-2ad39ea5e156","userEmail":"arsalan@alumni.princeton.edu","spaceName":"Arsalan Mosenia'\''s Notion","spaceId":"ac16b5bf-32cd-49e5-a9c6-7a7f52445cd1","spaceViewId":"18be1f56-751d-4ea9-adc4-577dc0bb4116","currentDatetime":"2025-10-16T18:55:38.538-07:00","surface":"workflows","blockId":"d21f2958-6d2c-440e-8e2f-9dd26c30c919","agentAccessory":"duck"}},{"id":"28f77d4b-cf24-8061-9c5a-00aabe7bd1f6","type":"user","value":[["What tools and capabilities do you have access to? List all available functions."]],"userId":"2e7b907e-5e54-4735-855c-2ad39ea5e156","createdAt":"2025-10-16T19:08:03.043-07:00"}],"threadId":"28f77d4b-cf24-8047-a5c8-00a903f9b563","createThread":false,"debugOverrides":{"emitAgentSearchExtractedResults":true,"cachedInferences":{},"annotationInferences":{},"emitInferences":false},"generateTitle":false,"saveAllThreadOperations":true,"threadType":"workflow","isPartialTranscript":true,"asPatchResponse":true}' \
  -o tool_discovery_response.ndjson

echo "Response received. Analyzing for security insights..."
echo ""
echo "=== SECURITY ANALYSIS ==="
echo ""

# Check response size
echo "Response size: $(wc -c < tool_discovery_response.ndjson) bytes"
echo ""

# Extract and analyze key information
echo "1. Checking for model information:"
grep -o '"model"[^,]*' tool_discovery_response.ndjson | head -5

echo ""
echo "2. Checking for thinking/reasoning blocks:"
grep -o '"thinking"[^}]*' tool_discovery_response.ndjson | head -5

echo ""
echo "3. Checking for encrypted content:"
grep -o '"encryptedContent"[^"]*"[^"]*"' tool_discovery_response.ndjson | head -5

echo ""
echo "4. Checking for tool/capability mentions:"
grep -i -o 'tool\|capability\|function\|enable' tool_discovery_response.ndjson | sort | uniq -c | head -10

echo ""
echo "5. Checking message types in response:"
grep -o '"type":"[^"]*"' tool_discovery_response.ndjson | sort | uniq -c

echo ""
echo "Full response saved to: tool_discovery_response.ndjson"