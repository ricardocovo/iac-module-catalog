// Basic deployment of Logic App Workflow with HTTP trigger
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module logicAppWorkflow '../main.bicep' = {
  name: 'logic-app-workflow-basic'
  params: {
    name: 'logic-app-http-${environment}-${uniqueString(resourceGroup().id)}'
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
          body: {
            receivedMessage: '@triggerBody()?[\'message\']'
            timestamp: '@utcNow()'
          }
        }
        runAfter: {}
      }
    }
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = logicAppWorkflow.outputs.resourceId
output name string = logicAppWorkflow.outputs.name
output location string = logicAppWorkflow.outputs.location
