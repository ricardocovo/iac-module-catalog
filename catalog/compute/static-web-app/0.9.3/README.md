# Static Web App Module

## Overview

This module deploys an Azure Static Web App using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/web/static-site:0.9.3`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/web/static-site)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the static web app |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Free'` | The SKU name (Free or Standard) |
| `customDomains` | array | `[]` | The custom domains to configure |
| `stagingEnvironmentPolicy` | string | `'Enabled'` | The staging environment policy (Enabled or Disabled) |
| `allowConfigFileUpdates` | bool | `true` | Allow configuration file updates |
| `buildProperties` | object | `{}` | The app build configuration |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `managedIdentities` | object | `{}` | Managed identity configuration |
| `tags` | object | `{}` | Resource tags |

## Outputs

This module returns the standard outputs from the underlying AVM module, including:
- `resourceId` - The resource ID
- `name` - The resource name
- `defaultHostname` - The default hostname of the static web app

## Usage

### Basic Deployment

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal configuration.

### Production Deployment

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready configuration with custom domain and Standard SKU.

## Example

```bicep
module staticWebApp '../static-web-app/main.bicep' = {
  name: 'swa-deployment'
  params: {
    name: 'my-static-web-app'
    location: 'eastus2'
    skuName: 'Free'
    tags: {
      environment: 'production'
      application: 'web'
    }
  }
}
```

## References

- [Azure Static Web Apps Documentation](https://learn.microsoft.com/azure/static-web-apps/)
- [Azure Verified Modules](https://aka.ms/avm)
