#!/usr/bin/env bash

# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "🩺 Running CFT test environment checks..."

FAILS=0

# 1. Check TF_VAR properties
REQUIRED_VARS=(
  "TF_VAR_org_id"
  "TF_VAR_folder_id"
  "TF_VAR_billing_account"
)

echo "Checking required Terraform environment variables..."
for VAR in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!VAR}" ]; then
    echo -e "${RED}[✗] Missing $VAR${NC}"
    FAILS=$((FAILS + 1))
  else
    echo -e "${GREEN}[✓] $VAR is set${NC}"
  fi
done

if [ $FAILS -gt 0 ]; then
  echo -e "\n${YELLOW}To fix the missing TF_VAR issues, ensure you export them in your shell:${NC}"
  echo 'export TF_VAR_org_id="<YOUR_ORG_ID>"'
  echo 'export TF_VAR_folder_id="<YOUR_FOLDER_ID>"'
  echo 'export TF_VAR_billing_account="<YOUR_BILLING_ACCOUNT>"'
  echo ""
fi

# 2. Check SERVICE_ACCOUNT_JSON
echo "Checking SERVICE_ACCOUNT_JSON..."
if [ -z "$SERVICE_ACCOUNT_JSON" ]; then
  echo -e "${RED}[✗] SERVICE_ACCOUNT_JSON is not set.${NC}"
  FAILS=$((FAILS + 1))
  echo -e "\n${YELLOW}To fix this, you must export the JSON contents of a Service Account key with Owner permissions on the target folder.${NC}"
  echo "Ask the Firebase team for access to the central billing project if needed, then run:"
  echo "gcloud iam service-accounts keys create /tmp/cft.json --iam-account=<SERVICE_ACCOUNT_EMAIL>"
  echo "export SERVICE_ACCOUNT_JSON=\$(< /tmp/cft.json)"
  echo ""
else
  # Verify valid JSON
  if echo "$SERVICE_ACCOUNT_JSON" | jq -e . >/dev/null 2>&1; then
    echo -e "${GREEN}[✓] SERVICE_ACCOUNT_JSON is set and is valid JSON${NC}"
  else
    echo -e "${RED}[✗] SERVICE_ACCOUNT_JSON is set but contains INVALID format.${NC}"
    FAILS=$((FAILS + 1))
    echo -e "\n${YELLOW}To fix this, ensure you are exporting the actual JSON contents, not the file path!${NC}"
    echo "Correct:   export SERVICE_ACCOUNT_JSON=\$(< /path/to/key.json)"
    echo 'Incorrect: export SERVICE_ACCOUNT_JSON="/path/to/key.json"'
    echo ""
  fi
fi

if [ $FAILS -gt 0 ]; then
  echo -e "${RED}Doctor found $FAILS issue(s). Please fix them before running tests.${NC}"
  exit 1
else
  echo -e "${GREEN}All checks passed! You are ready to run 'make docker_test_prepare'.${NC}"
  exit 0
fi
