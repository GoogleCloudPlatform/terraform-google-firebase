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

package firestore_rules

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

func TestFirestoreRules(t *testing.T) {
	firebaseTest := tft.NewTFBlueprintTest(t)

	firebaseTest.DefineVerify(func(assert *assert.Assertions) {
		firebaseTest.DefaultVerify(assert)

		projectID := firebaseTest.GetStringOutput("project_id")

		// 1. Verify Firestore API and Firebase Rules API are enabled
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{
			"--project", projectID,
			"--filter", "config.name:(firestore.googleapis.com OR firebaserules.googleapis.com)",
			"--format", "json",
		})).Array()
		expectedAPIs := []string{
			"firestore.googleapis.com",
			"firebaserules.googleapis.com",
		}
		for _, api := range expectedAPIs {
			match := utils.GetFirstMatchResult(t, services, "config.name", api)
			assert.Equal("ENABLED", match.Get("state").String(), fmt.Sprintf("%s should be enabled", api))
		}

		// 2. Obtain Access Token
		out, err := exec.Command("gcloud", "auth", "print-access-token").Output()
		assert.NoError(err, "Failed to get access token")
		token := strings.TrimSpace(string(out))

		// 3. Verify Firestore Rules Release
		releaseName := firebaseTest.GetStringOutput("release_name")
		release := firebase_util.GetFirestoreRulesRelease(t, projectID, releaseName, token)
		assert.True(release.Exists(), "Firestore rules release should exist")
		assert.True(strings.Contains(release.Get("name").String(), releaseName), "Release name %s should contain %s", release.Get("name").String(), releaseName)

		// 4. Verify Ruleset
		rulesetName := firebaseTest.GetStringOutput("ruleset_name")
		ruleset := firebase_util.GetFirestoreRulesRuleset(t, projectID, rulesetName, token)
		assert.True(ruleset.Exists(), "Ruleset should exist")

		// 5. Verify Rules content
		files := ruleset.Get("source.files").Array()
		assert.NotEmpty(files, "Ruleset should have files")
		assert.Equal("firestore.rules", files[0].Get("name").String(), "First file should be firestore.rules")
		assert.Contains(files[0].Get("content").String(), "service cloud.firestore", "Rules content should contain service cloud.firestore")
	})

	firebaseTest.Test()
}
