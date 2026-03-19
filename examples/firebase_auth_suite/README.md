# Firebase Auth Suite Example

This example demonstrates how to configure Firebase Authentication settings, including enabling email/password sign-in, anonymous sign-in, and configuring identity providers.

## Run Terraform

Create resources with terraform:

```bash
terraform init
terraform plan
terraform apply
```

To remove all resources created by terraform:

```bash
terraform destroy
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apple\_client\_secret | The content of the Apple Private Key file (.p8) | `string` | `"dummy-apple-client-secret"` | no |
| apple\_key\_id | The Apple Private Key ID | `string` | `"KEY1234567"` | no |
| apple\_service\_id | The Apple Service ID | `string` | `"com.example.app"` | no |
| apple\_team\_id | The Apple Team ID | `string` | `"ABC123DEFG"` | no |
| facebook\_app\_id | The Facebook App ID | `string` | `"12345678"` | no |
| facebook\_app\_secret | The Facebook App Secret | `string` | `"dummy-facebook-app-secret"` | no |
| github\_client\_id | The GitHub OAuth Client ID | `string` | `"dummy-github-client-id"` | no |
| github\_client\_secret | The GitHub OAuth Secret | `string` | `"dummy-github-client-secret"` | no |
| google\_client\_id | The Google Web Client ID | `string` | `"dummy-google-client-id"` | no |
| google\_client\_secret | The Google Web Client Secret | `string` | `"dummy-google-client-secret"` | no |
| project\_id | Project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| apple\_service\_id | Apple Service ID |
| facebook\_app\_id | Facebook App ID |
| github\_client\_id | GitHub Client ID |
| google\_client\_id | Google Client ID |
| project\_id | Project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
