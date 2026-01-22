// Basic deployment of Azure Function App
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
param serverFarmResourceId string
param storageAccountResourceId string
param storageAccountName string

module functionApp '../main.bicep' = {
  name: 'function-app-basic'
  params: {
    name: 'func-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    serverFarmResourceId: serverFarmResourceId
    storageAccountResourceId: storageAccountResourceId
    storageAccountName: storageAccountName
    functionAppRuntime: 'dotnet'
    functionAppRuntimeVersion: '8'
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = functionApp.outputs.resourceId
output name string = functionApp.outputs.name
output defaultHostname string = functionApp.outputs.defaultHostname
