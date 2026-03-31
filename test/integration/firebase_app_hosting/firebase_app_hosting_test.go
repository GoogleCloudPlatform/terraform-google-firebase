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

package firebase_app_hosting

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

func TestFirebaseAppHosting(t *testing.T) {
	firebaseTest := tft.NewTFBlueprintTest(t)

	firebaseTest.DefineVerify(func(assert *assert.Assertions) {
		firebaseTest.DefaultVerify(assert)

		projectID := firebaseTest.GetStringOutput("project_id")
		backendID := firebaseTest.GetStringOutput("backend_id")
		backendName := firebaseTest.GetStringOutput("backend_name")
		backendURI := firebaseTest.GetStringOutput("backend_uri")
		buildName := firebaseTest.GetStringOutput("build_name")

		// 1. Verify Enabled APIs
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})).Array()
		expectedAPIs := []string{
			"firebase.googleapis.com",
			"firebaseapphosting.googleapis.com",
			"run.googleapis.com",
			"cloudbuild.googleapis.com",
			"artifactregistry.googleapis.com",
		}
		for _, api := range expectedAPIs {
			match := utils.GetFirstMatchResult(t, services, "config.name", api)
			assert.Equal("ENABLED", match.Get("state").String(), fmt.Sprintf("%s should be enabled", api))
		}

		// 2. Verify Backend and Build via REST API
		out, err := exec.Command("gcloud", "auth", "print-access-token").Output()
		assert.NoError(err, "Failed to get access token")
		token := strings.TrimSpace(string(out))

		// Verify Backend
		backend := firebase_util.GetAppHostingBackend(t, projectID, "us-central1", backendID, token)
		assert.Equal(backendName, backend.Get("name").String(), "Backend name should match")
		assert.Equal(backendURI, backend.Get("uri").String(), "Backend URI should match")
		assert.Equal("GLOBAL_ACCESS", backend.Get("servingLocality").String(), "Serving locality should be GLOBAL_ACCESS")
		assert.Equal("production", backend.Get("environment").String(), "Environment should be production")
		assert.Equal(firebaseTest.GetStringOutput("service_account_email"), backend.Get("serviceAccount").String(), "Service account should match")

		// Verify Build
		builds := firebase_util.GetAppHostingBuilds(t, projectID, "us-central1", backendID, token)
		foundBuild := false
		for _, b := range builds {
			if b.Get("name").String() == buildName {
				foundBuild = true
				break
			}
		}
		assert.True(foundBuild, "Build should exist in the backend")
	})

	firebaseTest.Test()
}
