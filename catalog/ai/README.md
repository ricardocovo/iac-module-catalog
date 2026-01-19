# AI & Machine Learning Modules

Azure Verified Modules for AI and ML services in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Version | Description |
|--------|--------------|---------|-------------|
| [Azure AI Search](search-service.bicep) | `avm/res/search/search-service` | 0.8.0 | Azure AI Search for vector and full-text search |
| [Azure OpenAI](cognitive-services-account.bicep) | `avm/res/cognitive-services/account` | 0.7.0 | Azure OpenAI and Cognitive Services |
| [Azure ML Workspace](machine-learning-workspace.bicep) | `avm/res/machine-learning-services/workspace` | 0.7.0 | Azure ML Workspace (Microsoft Foundry) |

## Usage Example

```bicep
module openai './cognitive-services-account.bicep' = {
  name: 'openai-deployment'
  params: {
    name: 'oai-foundry-eastus2'
    location: 'eastus2'
    kind: 'OpenAI'
    publicNetworkAccess: 'Disabled'
    deployments: [
      {
        name: 'gpt-4'
        model: {
          format: 'OpenAI'
          name: 'gpt-4'
          version: '0613'
        }
        sku: {
          name: 'Standard'
          capacity: 10
        }
      }
    ]
    privateEndpoints: [
      {
        subnetResourceId: subnetId
        privateDnsZoneResourceIds: [dnsZoneId]
      }
    ]
  }
}
```
