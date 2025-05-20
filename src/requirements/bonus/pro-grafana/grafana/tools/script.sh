#!/bin/bash
# grafana_setup.sh - Automated Grafana dashboard setup script

# ====== CONFIGURATION ======
GRAFANA_URL="http://localhost:3000"
GRAFANA_USER="admin"
GRAFANA_PASSWORD="admin"  # Default password, change if needed
DASHBOARD_JSON_FILE="/etc/grafana/dashboards/cadvisor.json"  # Your cAdvisor dashboard JSON file
PROMETHEUS_URL="http://prometheus:9090"  # Your Prometheus URL

# ====== HELPER FUNCTIONS ======
# Function to check if Grafana is ready
wait_for_grafana() {
  echo "Waiting for Grafana to be ready..."
  until $(curl --output /dev/null --silent --head --fail --user "$GRAFANA_USER:$GRAFANA_PASSWORD" $GRAFANA_URL/api/health); do
    printf '.'
    sleep 2
  done
  echo "Grafana is up!"
}

# ====== MAIN SCRIPT ======
# Step 1: Wait for Grafana to be ready
wait_for_grafana

# Step 2: Create API key
echo "Creating API key..."
API_KEY=$(curl -s -X POST -H "Content-Type: application/json" \
  --user "$GRAFANA_USER:$GRAFANA_PASSWORD" \
  -d '{"name":"setup-script-key", "role":"Admin"}' \
  $GRAFANA_URL/api/auth/keys | grep -o '"key":"[^"]*' | grep -o '[^"]*$')

# Check if API key was created
if [ -z "$API_KEY" ]; then
  echo "Failed to create API key. Using service account approach..."
  
  # Create service account
  SERVICE_ACCOUNT_ID=$(curl -s -X POST -H "Content-Type: application/json" \
    --user "$GRAFANA_USER:$GRAFANA_PASSWORD" \
    -d '{"name":"setup-service-account", "role":"Admin"}' \
    $GRAFANA_URL/api/serviceaccounts | grep -o '"id":[0-9]*' | grep -o '[0-9]*')
  
  # Create token for service account
  API_KEY=$(curl -s -X POST -H "Content-Type: application/json" \
    --user "$GRAFANA_USER:$GRAFANA_PASSWORD" \
    -d '{"name":"setup-token"}' \
    $GRAFANA_URL/api/serviceaccounts/$SERVICE_ACCOUNT_ID/tokens | grep -o '"key":"[^"]*' | grep -o '[^"]*$')
fi

if [ -z "$API_KEY" ]; then
  echo "Failed to create API key or service account token!"
  exit 1
fi

echo "API key created successfully!"

# Step 3: Create Prometheus data source
echo "Creating Prometheus data source..."
DS_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
    "name":"Prometheus",
    "type":"prometheus",
    "url":"'"$PROMETHEUS_URL"'",
    "access":"proxy",
    "isDefault":true
  }' \
  $GRAFANA_URL/api/datasources)

# Extract the UID of the created data source
DS_UID=$(echo $DS_RESPONSE | grep -o '"uid":"[^"]*' | grep -o '[^"]*$')

# If we couldn't extract the UID, try to get it from a list of datasources
if [ -z "$DS_UID" ]; then
  echo "Could not extract UID from creation response. Fetching from datasources list..."
  DS_UID=$(curl -s -H "Authorization: Bearer $API_KEY" \
    $GRAFANA_URL/api/datasources | grep -o '"uid":"[^"]*' | head -1 | grep -o '[^"]*$')
fi

if [ -z "$DS_UID" ]; then
  echo "Failed to get data source UID. Using 'Prometheus' as the name instead."
  # We'll just use the name in the dashboard import
  DS_VALUE="Prometheus"
else
  echo "Data source created with UID: $DS_UID"
  DS_VALUE=$DS_UID
fi

# Step 4: Prepare dashboard JSON for import
echo "Preparing dashboard JSON..."
TMP_DASHBOARD=$(mktemp)

# Extract just the dashboard object from the file
cat "$DASHBOARD_JSON_FILE" | jq '{
  dashboard: .,
  overwrite: true,
  inputs: [
    {
      "name": "DS_PROMETHEUS",
      "type": "datasource", 
      "pluginId": "prometheus",
      "value": "'"$DS_VALUE"'"
    }
  ]
}' > "$TMP_DASHBOARD"

# Step 5: Import the dashboard
echo "Importing dashboard..."
IMPORT_RESPONSE=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d @"$TMP_DASHBOARD" \
  $GRAFANA_URL/api/dashboards/db)

# Check import response
if echo $IMPORT_RESPONSE | grep -q '"imported":true'; then
  DASHBOARD_UID=$(echo $IMPORT_RESPONSE | grep -o '"uid":"[^"]*' | grep -o '[^"]*$')
  echo "Dashboard imported successfully! UID: $DASHBOARD_UID"
  echo "You can access it at: $GRAFANA_URL/d/$DASHBOARD_UID"
else
  echo "Failed to import dashboard. Response:"
  echo $IMPORT_RESPONSE
fi

# Clean up
rm "$TMP_DASHBOARD"

# Optional: Remove API key for security
# curl -X DELETE -H "Authorization: Bearer $API_KEY" $GRAFANA_URL/api/auth/keys/1

echo "Setup completed!"
