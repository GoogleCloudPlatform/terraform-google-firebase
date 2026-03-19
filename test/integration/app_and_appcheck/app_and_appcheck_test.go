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

	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/GoogleCloudPlatform/terraform-google-firebase/test/integration/firebase_util"
	"github.com/stretchr/testify/assert"
)

func TestAppAndAppCheck(t *testing.T) {
	firebaseTest := tft.NewTFBlueprintTest(t,
		tft.WithTFDir("../../../examples/app_and_appcheck"),
	)

	firebaseTest.DefineVerify(func(assert *assert.Assertions) {
		firebaseTest.DefaultVerify(assert)

		projectID := firebaseTest.GetStringOutput("project_id")

		// 1. Verify Enabled APIs
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})).Array()
		expectedAPIs := []string{
			"firebase.googleapis.com",
			"firebaseappcheck.googleapis.com",
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

		webAppId := verifyApp(firebase_util.Web)
		androidAppId := verifyApp(firebase_util.Android)
		iosAppId := verifyApp(firebase_util.IOS)

		// 3. Verify the app_check_bundle output size & enabled_app_ids
		enabledAppIds := terraform.OutputList(t, firebaseTest.GetTFOptions(), "enabled_app_ids")
		assert.Len(enabledAppIds, 3, "Should have exactly 3 enabled_app_ids output from App Check module")

		// 4. Verify App Check Attestation configurations via REST API
		// Check Web RecaptchaConfig
		webConfig := firebase_util.GetAppCheckConfig(t, projectID, webAppId, "recaptchaEnterpriseConfig", token)
		assert.NotEmpty(webConfig.Get("siteKey").String(), "Web App should have recaptcha enterprise config attached")

		// Check Android PlayIntegrityConfig
		androidConfig := firebase_util.GetAppCheckConfig(t, projectID, androidAppId, "playIntegrityConfig", token)
		assert.Contains(androidConfig.Get("name").String(), fmt.Sprintf("apps/%s/playIntegrityConfig", androidAppId), "Android App should have play integrity config attached")

		// Check iOS DeviceCheckConfig
		iosConfig := firebase_util.GetAppCheckConfig(t, projectID, iosAppId, "deviceCheckConfig", token)
		assert.Contains(iosConfig.Get("name").String(), fmt.Sprintf("apps/%s/deviceCheckConfig", iosAppId), "iOS App should have device check config attached")
	})

	firebaseTest.Test()
}
