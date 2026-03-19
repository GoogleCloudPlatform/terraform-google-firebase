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

package firebase_auth_suite

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
	"github.com/tidwall/gjson"
)

func TestFirebaseAuthSuite(t *testing.T) {
	firebaseTest := tft.NewTFBlueprintTest(t)

	firebaseTest.DefineVerify(func(assert *assert.Assertions) {
		firebaseTest.DefaultVerify(assert)

		projectID := firebaseTest.GetStringOutput("project_id")

		// 1. Verify Identity Toolkit API is enabled
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})).Array()
		api := "identitytoolkit.googleapis.com"
		match := utils.GetFirstMatchResult(t, services, "config.name", api)
		assert.Equal("ENABLED", match.Get("state").String(), fmt.Sprintf("%s should be enabled", api))

		// 2. Verify Auth Configuration via REST API
		out, err := exec.Command("gcloud", "auth", "print-access-token").Output()
		assert.NoError(err, "Failed to get access token")
		token := strings.TrimSpace(string(out))

		authConfig := firebase_util.GetAuthConfig(t, projectID, token)

		// Verify project-level sign-in settings
		assert.True(authConfig.Get("signIn.email.enabled").Bool(), "Email sign-in should be enabled")
		assert.True(authConfig.Get("signIn.anonymous.enabled").Bool(), "Anonymous sign-in should be enabled")
		assert.False(authConfig.Get("signIn.allowDuplicateEmails").Bool(), "Duplicate emails should be disabled")

		// 3. Verify Social Identity Providers
		idpConfigs := firebase_util.GetIdpConfigs(t, projectID, token)

		expectedIdps := map[string]string{
			"google.com":   firebaseTest.GetStringOutput("google_client_id"),
			"facebook.com": firebaseTest.GetStringOutput("facebook_app_id"),
			"github.com":   firebaseTest.GetStringOutput("github_client_id"),
			"apple.com":    firebaseTest.GetStringOutput("apple_service_id"),
		}

		for idpId, expectedClientId := range expectedIdps {
			var idpMatch gjson.Result
			for _, config := range idpConfigs {
				if strings.HasSuffix(config.Get("name").String(), "/"+idpId) {
					idpMatch = config
					break
				}
			}
			assert.True(idpMatch.Exists(), fmt.Sprintf("Provider %s should be configured in %v", idpId, idpConfigs))
			assert.True(idpMatch.Get("enabled").Bool(), fmt.Sprintf("Provider %s should be enabled", idpId))
			assert.Equal(expectedClientId, idpMatch.Get("clientId").String(), fmt.Sprintf("Provider %s should have correct client ID", idpId))
		}
	})

	firebaseTest.Test()
}
