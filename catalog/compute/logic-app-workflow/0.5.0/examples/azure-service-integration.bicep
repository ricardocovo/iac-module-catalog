// Logic App Workflow with Azure Service Integration
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param logAnalyticsWorkspaceId string

module logicApp '../main.bicep' = {
  name: 'logic-app-integration'
  params: {
    name: 'logic-integration-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    state: 'Enabled'
    workflowTriggers: {
      When_a_blob_is_added: {
        type: 'ApiConnection'
        inputs: {
          host: {
            connection: {
              name: '@parameters(\'$connections\')[\'azureblob\'][\'connectionId\']'
            }
          }
          method: 'get'
          path: '/datasets/default/triggers/batch/onupdatedfile'
          queries: {
            folderId: 'uploads'
            maxFileCount: 10
          }
        }
        recurrence: {
          frequency: 'Minute'
          interval: 5
        }
        splitOn: '@triggerBody()'
      }
    }
    workflowActions: {
      Get_blob_content: {
        type: 'ApiConnection'
        inputs: {
          host: {
            connection: {
              name: '@parameters(\'$connections\')[\'azureblob\'][\'connectionId\']'
            }
          }
          method: 'get'
          path: '/datasets/default/files/@{encodeURIComponent(encodeURIComponent(triggerBody()?[\'Id\']))}/content'
        }
        runAfter: {}
      }
      Process_content: {
        type: 'Compose'
        inputs: {
          fileName: '@triggerBody()?[\'Name\']'
          fileSize: '@triggerBody()?[\'Size\']'
          processedAt: '@utcNow()'
          content: '@base64ToString(body(\'Get_blob_content\'))'
        }
        runAfter: {
          Get_blob_content: [
            'Succeeded'
          ]
        }
      }
      Log_result: {
        type: 'Compose'
        inputs: {
          status: 'completed'
          details: '@outputs(\'Process_content\')'
        }
        runAfter: {
          Process_content: [
            'Succeeded'
          ]
        }
      }
    }
    workflowParameters: {
      '$connections': {
        defaultValue: {}
        type: 'Object'
      }
    }
    managedIdentities: {
      systemAssigned: true
    }
    diagnosticSettings: [
      {
        name: 'diag-${environment}'
        workspaceResourceId: logAnalyticsWorkspaceId
        logCategoriesAndGroups: [
          {
            categoryGroup: 'allLogs'
            enabled: true
          }
        ]
        metricCategories: [
          {
            category: 'AllMetrics'
            enabled: true
          }
        ]
      }
    ]
    roleAssignments: [
      {
        principalId: '00000000-0000-0000-0000-000000000000' // Replace with actual principal ID
        roleDefinitionIdOrName: 'Storage Blob Data Reader'
        principalType: 'ServicePrincipal'
      }
    ]
    tags: {
      environment: environment
      deploymentType: 'integration'
      integration: 'blob-storage'
    }
  }
}

output resourceId string = logicApp.outputs.resourceId
output name string = logicApp.outputs.name
output systemAssignedPrincipalId string = logicApp.outputs.systemAssignedPrincipalId
