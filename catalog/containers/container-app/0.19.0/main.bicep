// Azure Verified Module Reference: Container App
// Registry: br/public:avm/res/app/container-app

metadata name = 'Container App'
metadata description = 'AVM reference for deploying Azure Container Apps'
metadata owner = 'Azure Verified Modules'

@description('The name of the container app')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Container Apps environment resource ID')
param environmentResourceId string

@description('Container configuration')
param containers array

@description('Ingress configuration')
param ingressConfiguration object = {}

@description('Scale configuration')
param scaleConfiguration object = {}

@secure()
@description('Secrets configuration object')
param secretsConfiguration object = {}

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module containerApp 'br/public:avm/res/app/container-app:0.19.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    environmentResourceId: environmentResourceId
    containers: containers
    ingressExternal: ingressConfiguration.?external ?? false
    ingressTargetPort: ingressConfiguration.?targetPort ?? 80
    ingressTransport: ingressConfiguration.?transport ?? 'http'
    scaleSettings: {
      minReplicas: scaleConfiguration.?minReplicas ?? 0
      maxReplicas: scaleConfiguration.?maxReplicas ?? 10
      rules: scaleConfiguration.?rules ?? []
    }
    secrets: !empty(secretsConfiguration) ? items(secretsConfiguration) : []
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = containerApp.outputs.resourceId
output name string = containerApp.outputs.name
output fqdn string = containerApp.outputs.fqdn
