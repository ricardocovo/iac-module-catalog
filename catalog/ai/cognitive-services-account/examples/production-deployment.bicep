// Production deployment of Cognitive Services Account with private endpoint
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param vnetResourceGroupName string
param vnetName string
param subnetName string

// Get existing virtual network
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  scope: resourceGroup(vnetResourceGroupName)
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' existing = {
  parent: vnet
  name: subnetName
}

module cognitiveServices '../main.bicep' = {
  name: 'cognitive-services-prod'
  params: {
    name: 'openai-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    kind: 'OpenAI'
    skuName: 'S0'
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
        name: 'pe-openai-${environment}'
        subnetResourceId: subnet.id
        privateDnsZoneGroup: {
          privateDnsZoneGroupConfigs: [
            {
              privateDnsZoneResourceId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${vnetResourceGroupName}/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com'
            }
          ]
        }
      }
    ]
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = cognitiveServices.outputs.resourceId
output endpoint string = cognitiveServices.outputs.endpoint
output name string = cognitiveServices.outputs.name
