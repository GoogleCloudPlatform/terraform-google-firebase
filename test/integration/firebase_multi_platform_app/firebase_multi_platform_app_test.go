/**
 * Copyright 2026 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package firebase_multi_platform_app

import (
	"fmt"
	"os/exec"
	"strings"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/GoogleCloudPlatform/terraform-google-firebase/test/integration/firebase_util"
	"github.com/stretchr/testify/assert"
)

func TestFirebaseMultiPlatformApp(t *testing.T) {
	firebaseTest := tft.NewTFBlueprintTest(t)

	firebaseTest.DefineVerify(func(assert *assert.Assertions) {
		firebaseTest.DefaultVerify(assert)

		projectID := firebaseTest.GetStringOutput("project_id")

		// 1. Verify Enabled APIs
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})).Array()
		expectedAPIs := []string{
			"firebase.googleapis.com",
			"serviceusage.googleapis.com",
			"cloudresourcemanager.googleapis.com",
			"identitytoolkit.googleapis.com",
		}
		for _, api := range expectedAPIs {
			match := utils.GetFirstMatchResult(t, services, "config.name", api)
			assert.Equal("ENABLED", match.Get("state").String(), fmt.Sprintf("%s should be enabled", api))
		}

		// 2. Verify Apps via REST API
		out, err := exec.Command("gcloud", "auth", "print-access-token").Output()
		assert.NoError(err, "Failed to get access token")
		token := strings.TrimSpace(string(out))

		verifyApp := func(appType firebase_util.AppType) {
			results := firebase_util.GetAppList(t, projectID, appType, token)
			assert.Len(results, 1, fmt.Sprintf("Should have exactly one %s registered", appType.Label()))
		}

		verifyApp(firebase_util.Web)
		verifyApp(firebase_util.Android)
		verifyApp(firebase_util.IOS)
	})

	firebaseTest.Test()
}
