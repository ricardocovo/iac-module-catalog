# AI & Machine Learning Modules

Azure Verified Modules for AI and ML services in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Azure AI Search](search-service/) | `avm/res/search/search-service` | [0.9.2](search-service/0.9.2/) \| [0.10.0](search-service/0.10.0/) \| [0.11.0](search-service/0.11.0/) \| [0.11.1](search-service/0.11.1/) \| [0.12.0](search-service/0.12.0/) | Azure AI Search for vector and full-text search |
| [Azure OpenAI](cognitive-services-account/) | `avm/res/cognitive-services/account` | [0.13.0](cognitive-services-account/0.13.0/) \| [0.13.1](cognitive-services-account/0.13.1/) \| [0.13.2](cognitive-services-account/0.13.2/) \| [0.14.0](cognitive-services-account/0.14.0/) \| [0.14.1](cognitive-services-account/0.14.1/) | Azure OpenAI and Cognitive Services |
| [Azure ML Workspace](machine-learning-workspace/) | `avm/res/machine-learning-services/workspace` | [0.11.0](machine-learning-workspace/0.11.0/) \| [0.11.1](machine-learning-workspace/0.11.1/) \| [0.12.0](machine-learning-workspace/0.12.0/) \| [0.12.1](machine-learning-workspace/0.12.1/) \| [0.13.0](machine-learning-workspace/0.13.0/) | Azure ML Workspace (Microsoft Foundry) |

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
