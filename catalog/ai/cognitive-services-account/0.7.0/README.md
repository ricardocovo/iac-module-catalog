# Cognitive Services Account Module

## Overview

This module deploys an Azure Cognitive Services account (including Azure OpenAI) using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/cognitive-services/account:0.7.0`
- **Documentation**: [Azure Cognitive Services AVM](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/cognitive-services/account)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the cognitive services account |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `kind` | string | `'OpenAI'` | Kind of cognitive service (OpenAI, CognitiveServices, FormRecognizer, ComputerVision) |
| `skuName` | string | `'S0'` | SKU name for the service |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access (Enabled/Disabled) |
| `customSubDomainName` | string | `name` | Custom subdomain name |
| `deployments` | array | `[]` | Array of model deployments |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `managedIdentities` | object | `{}` | Managed identity configuration |
| `tags` | object | `{}` | Resource tags |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `resourceId` | string | The resource ID of the cognitive services account |
| `name` | string | The name of the cognitive services account |
| `endpoint` | string | The endpoint URL |

## Usage

### Basic Deployment

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal configuration.

### Production Deployment

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready configuration with private endpoints.

## Example

```bicep
module cognitiveServices '../cognitive-services-account/main.bicep' = {
  name: 'cognitive-services-deployment'
  params: {
    name: 'my-openai-account'
    location: 'eastus'
    kind: 'OpenAI'
    skuName: 'S0'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Cognitive Services Documentation](https://learn.microsoft.com/azure/cognitive-services/)
- [Azure OpenAI Service Documentation](https://learn.microsoft.com/azure/cognitive-services/openai/)
