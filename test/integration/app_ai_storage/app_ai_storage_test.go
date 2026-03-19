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

package complex_cujs

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

func TestAppAiStorage(t *testing.T) {
	firebaseTest := tft.NewTFBlueprintTest(t,
		tft.WithTFDir("../../../examples/app_ai_storage"),
	)

	firebaseTest.DefineVerify(func(assert *assert.Assertions) {
		firebaseTest.DefaultVerify(assert)

		projectID := firebaseTest.GetStringOutput("project_id")
		location := "global"
		bucketName := firebaseTest.GetStringOutput("bucket_name")
		objectName := firebaseTest.GetStringOutput("object_name")
		templateId := firebaseTest.GetStringOutput("template_id")

		// 1. Verify Enabled APIs
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})).Array()
		expectedAPIs := []string{
			"firebase.googleapis.com",
			"firebasevertexai.googleapis.com",
			"generativelanguage.googleapis.com",
		}
		for _, api := range expectedAPIs {
			match := utils.GetFirstMatchResult(t, services, "config.name", api)
			assert.Equal("ENABLED", match.Get("state").String(), fmt.Sprintf("%s should be enabled", api))
		}

		// 2. Verify Apps via REST API
		out, err := exec.Command("gcloud", "auth", "print-access-token").Output()
		assert.NoError(err, "Failed to get access token")
		token := strings.TrimSpace(string(out))

		verifyApp := func(appType firebase_util.AppType) string {
			results := firebase_util.GetAppList(t, projectID, appType, token)
			assert.Len(results, 1, fmt.Sprintf("Should have exactly one %s registered", appType.Label()))
			return results[0].Get("appId").String()
		}

		verifyApp(firebase_util.Web)

		// 3. Verify Cloud Storage Object
		storageOut, err := exec.Command("gcloud", "storage", "cat", fmt.Sprintf("gs://%s/%s", bucketName, objectName)).Output()
		assert.NoError(err, "Failed to read GCS object")
		assert.Contains(string(storageOut), "Hello from an integration test GCS prompt!")

		// 4. Verify AI Logic Prompt Template via API
		templates := firebase_util.GetAiLogicTemplates(t, projectID, location, token)
		assert.GreaterOrEqual(len(templates), 1, "Should have at least one AI Logic template in the project")
		foundTemplate := false
		for _, tmpl := range templates {
			if strings.Contains(tmpl.Get("name").String(), templateId) {
				foundTemplate = true
				break
			}
		}
		assert.True(foundTemplate, "Expected prompt template ID not found in the project's templates list")

	})

	firebaseTest.Test()
}
