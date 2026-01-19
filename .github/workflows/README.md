# GitHub Actions Workflows

## Publish Bicep Modules to ACR

This workflow automatically publishes Bicep modules to Azure Container Registry when changes are detected.

### Features

- **Automatic Publishing**: Publishes modules when `main.bicep` files change in the `catalog/` directory
- **Version Detection**: Extracts version from AVM module references
- **Duplicate Prevention**: Only publishes if the version doesn't already exist in ACR
- **Parallel Processing**: Publishes multiple modules concurrently (max 5 at a time)
- **OIDC Authentication**: Uses Azure workload identity federation (no long-lived secrets)
- **Security Hardened**: Least privilege permissions, pinned action versions

### Repository Naming Convention

Modules are published to ACR using the pattern:
```
bicep/{category}/{module-name}:{version}
```

**Examples:**
- `bicep/ai/cognitive-services-account:0.7.0`
- `bicep/network/virtual-network:0.4.0`
- `bicep/data/cosmos-db-account:0.9.0`

### Required Secrets

Configure these secrets in your GitHub repository:

| Secret | Description | Example |
|--------|-------------|---------|
| `AZURE_CLIENT_ID` | Azure AD App Registration Client ID | `00000000-0000-0000-0000-000000000000` |
| `AZURE_TENANT_ID` | Azure AD Tenant ID | `00000000-0000-0000-0000-000000000000` |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID | `00000000-0000-0000-0000-000000000000` |
| `ACR_NAME` | Azure Container Registry name | `myacr` (without .azurecr.io) |

### Azure Setup (OIDC)

#### 1. Create Azure Container Registry

```bash
# Create resource group
az group create --name rg-bicep-modules --location canadacentral

# Create ACR with Premium SKU (required for zone redundancy)
az acr create \
  --name myacr \
  --resource-group rg-bicep-modules \
  --sku Premium \
  --location canadacentral
```

#### 2. Create Azure AD App Registration

```bash
# Create app registration
APP_ID=$(az ad app create \
  --display-name "GitHub Actions - Bicep Module Publisher" \
  --query appId -o tsv)

# Create service principal
SP_ID=$(az ad sp create --id $APP_ID --query id -o tsv)

echo "Client ID: $APP_ID"
```

#### 3. Configure Federated Credentials

```bash
# Get your GitHub repository details
GITHUB_ORG="ricardocovo"
GITHUB_REPO="iac-module-catalog"

# Create federated credential for main branch
az ad app federated-credential create \
  --id $APP_ID \
  --parameters '{
    "name": "github-main-branch",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:'$GITHUB_ORG'/'$GITHUB_REPO':ref:refs/heads/main",
    "audiences": ["api://AzureADTokenExchange"]
  }'
```

#### 4. Assign ACR Permissions

```bash
# Get ACR resource ID
ACR_ID=$(az acr show --name myacr --query id -o tsv)

# Assign AcrPush role (allows push/pull)
az role assignment create \
  --assignee $APP_ID \
  --role AcrPush \
  --scope $ACR_ID
```

#### 5. Configure GitHub Secrets

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

```bash
# Get the values
echo "AZURE_CLIENT_ID: $APP_ID"
echo "AZURE_TENANT_ID: $(az account show --query tenantId -o tsv)"
echo "AZURE_SUBSCRIPTION_ID: $(az account show --query id -o tsv)"
echo "ACR_NAME: myacr"
```

### Usage

#### Automatic Trigger

The workflow runs automatically when:
- Changes are pushed to `main` branch
- Any `main.bicep` file in `catalog/` is modified

#### Manual Trigger

Trigger manually from GitHub Actions UI:
1. Go to Actions → "Publish Bicep Modules to ACR"
2. Click "Run workflow"
3. Optionally enable "Force publish" to overwrite existing versions

### Consuming Published Modules

After publishing, reference modules in your Bicep templates:

```bicep
module vnet 'br:myacr.azurecr.io/bicep/network/virtual-network:0.4.0' = {
  name: 'vnet-deployment'
  params: {
    name: 'vnet-hub-foundry-cac'
    location: 'canadacentral'
    addressPrefixes: ['10.0.0.0/16']
  }
}
```

Or use the major version tag (always points to latest minor/patch):

```bicep
module vnet 'br:myacr.azurecr.io/bicep/network/virtual-network:v0' = {
  // ...
}
```

### Troubleshooting

#### Authentication Failures

```
Error: AADSTS700016: Application with identifier was not found
```

**Solution**: Verify the `AZURE_CLIENT_ID` secret matches your App Registration.

#### ACR Permission Denied

```
Error: unauthorized: authentication required
```

**Solution**: Ensure the service principal has `AcrPush` role on the ACR.

#### Version Already Exists

If a version already exists, the workflow skips publishing. To force republish:
1. Trigger workflow manually
2. Enable "Force publish" option

### Security Considerations

- **OIDC Authentication**: No long-lived credentials stored
- **Least Privilege**: Service principal only has ACR push permissions
- **Immutable Versions**: Existing versions are not overwritten (unless forced)
- **Audit Trail**: All publishes logged in GitHub Actions
- **Concurrency Control**: Prevents simultaneous publishes

### Workflow Security Checklist

- [x] Actions pinned to specific versions (@v4, @v2, @v44)
- [x] Default permissions: read-only (`contents: read`)
- [x] OIDC for Azure authentication (`id-token: write`)
- [x] No hardcoded secrets or credentials
- [x] Concurrency control configured
- [x] Error handling with `set -euo pipefail`
- [x] Comprehensive logging and summaries
- [x] Fail-fast disabled for parallel module processing

### Monitoring

View workflow execution details:
- **Actions Tab**: See all workflow runs and logs
- **Step Summary**: Each run includes a markdown summary with:
  - Module details (name, category, version)
  - Publication status
  - Usage examples

### Cost Optimization

- **Changed Files Detection**: Only processes modified modules
- **Parallel Processing**: Maximum 5 concurrent publishes
- **Skip Existing**: Doesn't republish unchanged versions
- **Minimal Runner Time**: Optimized steps for fast execution
