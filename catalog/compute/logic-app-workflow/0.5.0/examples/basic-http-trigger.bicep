// Basic HTTP-triggered Logic App Workflow
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module logicApp '../main.bicep' = {
  name: 'logic-app-http-basic'
  params: {
    name: 'logic-http-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    state: 'Enabled'
    workflowTriggers: {
      manual: {
        type: 'Request'
        kind: 'Http'
        inputs: {
          schema: {
            type: 'object'
            properties: {
              message: {
                type: 'string'
              }
            }
          }
        }
      }
    }
    workflowActions: {
      Response: {
        type: 'Response'
        kind: 'Http'
        inputs: {
          statusCode: 200
          headers: {
            'Content-Type': 'application/json'
          }
          body: {
            message: 'Request processed successfully'
            receivedAt: '@{utcNow()}'
          }
        }
        runAfter: {}
      }
    }
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = logicApp.outputs.resourceId
output name string = logicApp.outputs.name
