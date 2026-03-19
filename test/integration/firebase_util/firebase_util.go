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

package firebase_util

import (
	"fmt"
	"io"
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/tidwall/gjson"
)

// AppType represents a type of Firebase application.
type AppType string

const (
	Web     AppType = "webApps"
	Android AppType = "androidApps"
	IOS     AppType = "iosApps"
)

// Label returns a friendly label for the application type.
func (a AppType) Label() string {
	switch a {
	case Web:
		return "WEB"
	case Android:
		return "ANDROID"
	case IOS:
		return "IOS"
	default:
		return string(a)
	}
}

// GetAppList retrieves the list of apps for a given platform from the Firebase Management API.
func GetAppList(t *testing.T, projectId string, appType AppType, token string) []gjson.Result {
	url := fmt.Sprintf("https://firebase.googleapis.com/v1beta1/projects/%s/%s", projectId, appType)
	t.Logf("Fetching %s list from: %s", appType.Label(), url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body).Get("apps").Array()
}

// GetAuthConfig retrieves the project-level Identity Platform configuration.
func GetAuthConfig(t *testing.T, projectId string, token string) gjson.Result {
	url := fmt.Sprintf("https://identitytoolkit.googleapis.com/admin/v2/projects/%s/config", projectId)
	t.Logf("Fetching Identity Platform config from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body)
}

// GetIdpConfigs retrieves the list of configured default supported identity providers.
func GetIdpConfigs(t *testing.T, projectId string, token string) []gjson.Result {
	url := fmt.Sprintf("https://identitytoolkit.googleapis.com/admin/v2/projects/%s/defaultSupportedIdpConfigs", projectId)
	t.Logf("Fetching Identity Providers from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body).Get("defaultSupportedIdpConfigs").Array()
}

// GetAiLogicConfig retrieves the global AI Logic configuration for a project/location.
func GetAiLogicConfig(t *testing.T, projectId string, location string, token string) gjson.Result {
	url := fmt.Sprintf("https://firebasevertexai.googleapis.com/v1beta/projects/%s/locations/%s/config", projectId, location)
	t.Logf("Fetching AI Logic config from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body)
}

// GetAiLogicTemplates retrieves the list of prompt templates for original project/location.
func GetAiLogicTemplates(t *testing.T, projectId string, location string, token string) []gjson.Result {
	url := fmt.Sprintf("https://firebasevertexai.googleapis.com/v1beta/projects/%s/locations/%s/templates", projectId, location)
	t.Logf("Fetching AI Logic templates from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body).Get("templates").Array()
}

// GetFirestoreRulesRelease retrieves a specific Firebase Rules release.
func GetFirestoreRulesRelease(t *testing.T, projectId string, releaseName string, token string) gjson.Result {
	url := fmt.Sprintf("https://firebaserules.googleapis.com/v1/projects/%s/releases/%s", projectId, releaseName)
	t.Logf("Fetching Firestore Rules release from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body)
}

// GetFirestoreRulesRuleset retrieves a specific Firebase Rules ruleset.
func GetFirestoreRulesRuleset(t *testing.T, projectId string, rulesetName string, token string) gjson.Result {
	url := fmt.Sprintf("https://firebaserules.googleapis.com/v1/projects/%s/rulesets/%s", projectId, rulesetName)
	t.Logf("Fetching Firestore Rules ruleset from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body)
}

// GetAppHostingBackend retrieves an App Hosting backend.
func GetAppHostingBackend(t *testing.T, projectId string, location string, backendId string, token string) gjson.Result {
	url := fmt.Sprintf("https://firebaseapphosting.googleapis.com/v1beta/projects/%s/locations/%s/backends/%s", projectId, location, backendId)
	t.Logf("Fetching App Hosting backend from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body)
}

// GetAppHostingBuilds retrieves the list of builds for an App Hosting backend.
func GetAppHostingBuilds(t *testing.T, projectId string, location string, backendId string, token string) []gjson.Result {
	url := fmt.Sprintf("https://firebaseapphosting.googleapis.com/v1beta/projects/%s/locations/%s/backends/%s/builds", projectId, location, backendId)
	t.Logf("Fetching App Hosting builds from: %s", url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectId)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body).Get("builds").Array()
}

// GetAppCheckConfig fetches App Check config to verify attestation has been attached.
func GetAppCheckConfig(t *testing.T, projectID string, appID string, configType string, token string) gjson.Result {
	url := fmt.Sprintf("https://firebaseappcheck.googleapis.com/v1/projects/%s/apps/%s/%s", projectID, appID, configType)
	t.Logf("Fetching App Check %s from: %s", configType, url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	assert.NoError(t, err, "Failed to create HTTP request")

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("X-Goog-User-Project", projectID)

	resp, err := client.Do(req)
	assert.NoError(t, err, "HTTP request failed")
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err, "Failed to read response body")

	if resp.StatusCode != http.StatusOK {
		t.Fatalf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	return gjson.ParseBytes(body)
}
