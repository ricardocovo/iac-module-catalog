# Function App Module

## Overview

This module deploys an Azure Function App using Azure Verified Modules (AVM). Azure Functions is a serverless compute service that enables you to run event-driven code without having to explicitly provision or manage infrastructure.

## Module Reference

- **AVM Module**: `br/public:avm/res/web/site:0.8.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/web/site)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the function app |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `serverFarmResourceId` | string | Required | App Service Plan resource ID |
| `kind` | string | `'functionapp'` | Kind of site (use `functionapp` for Windows or `functionapp,linux` for Linux) |
| `siteConfig` | object | `{}` | Site configuration settings |
| `appSettingsKeyValuePairs` | object | `{}` | Additional app settings key-value pairs |
| `virtualNetworkSubnetId` | string | `''` | Virtual network subnet ID for VNet integration |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `managedIdentities` | object | `{}` | Managed identity configuration |
| `tags` | object | `{}` | Resource tags |
| `storageAccountResourceId` | string | `''` | Storage account resource ID (required for function app) |
| `storageAccountName` | string | `''` | Storage account name (required for function app) |
| `applicationInsightsResourceId` | string | `''` | Application Insights resource ID for monitoring |
| `functionAppRuntime` | string | `'dotnet'` | Function app runtime (dotnet, node, python, java, powershell, custom) |
| `functionAppRuntimeVersion` | string | `'8'` | Function app runtime version |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `resourceId` | string | The resource ID of the function app |
| `name` | string | The name of the function app |
| `defaultHostname` | string | The default hostname of the function app |
| `systemAssignedPrincipalId` | string | The principal ID of the system-assigned managed identity |

## Usage

### Basic Deployment

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal configuration.

### Production Deployment

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready configuration with VNet integration and private endpoints.

## Example

```bicep
module functionApp '../function-app/0.8.0/main.bicep' = {
  name: 'function-app-deployment'
  params: {
    name: 'my-function-app'
    location: 'eastus'
    serverFarmResourceId: appServicePlan.outputs.resourceId
    storageAccountResourceId: storage.outputs.resourceId
    storageAccountName: storage.outputs.name
    applicationInsightsResourceId: appInsights.outputs.resourceId
    functionAppRuntime: 'dotnet'
    functionAppRuntimeVersion: '8'
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: 'production'
      application: 'my-app'
    }
  }
}
```

## Notes

- Azure Functions requires a storage account for storing function app state and logs
- Application Insights is highly recommended for monitoring and diagnostics
- The module automatically configures required app settings like `AzureWebJobsStorage`, `WEBSITE_CONTENTAZUREFILECONNECTIONSTRING`, and `FUNCTIONS_EXTENSION_VERSION`
- For Linux function apps, set `kind` to `'functionapp,linux'`
- Supported runtimes: dotnet, node, python, java, powershell, custom

## Related Modules

- [App Service Plan](../../app-service-plan/)
- [Storage Account](../../../storage/storage-account/)
- [Application Insights](../../../monitoring/application-insights/)
