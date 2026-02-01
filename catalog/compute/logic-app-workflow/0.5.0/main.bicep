// Azure Verified Module Reference: Logic App Workflow
// Registry: br/public:avm/res/logic/workflow

metadata name = 'Logic App Workflow'
metadata description = 'AVM reference for deploying Azure Logic App Workflows'
metadata owner = 'Azure Verified Modules'

@description('The name of the logic app workflow')
param name string

@description('The location')
param location string = resourceGroup().location

@description('The state of the workflow - NotSpecified, Completed, Enabled, Disabled, Deleted, Suspended')
@allowed([
  'Completed'
  'Deleted'
  'Disabled'
  'Enabled'
  'NotSpecified'
  'Suspended'
])
param state string = 'Enabled'

@description('The definitions for one or more triggers that instantiate your workflow')
param workflowTriggers object = {}

@description('The definitions for one or more actions to execute at workflow runtime')
param workflowActions object = {}

@description('The definitions for the outputs to return from a workflow run')
param workflowOutputs object = {}

@description('The definitions for one or more parameters that pass the values to use at your logic apps runtime')
param workflowParameters object = {}

@description('Managed identity configuration')
param managedIdentities object = {}

@description('The integration account configuration')
param integrationAccount object = {}

@description('Role assignments to create')
param roleAssignments array = []

@description('Diagnostic settings configuration')
param diagnosticSettings array = []

@description('Lock configuration')
param lock object = {}

@description('Tags')
param tags object = {}

@description('Enable telemetry')
param enableTelemetry bool = true

module logicAppWorkflow 'br/public:avm/res/logic/workflow:0.5.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    state: state
    workflowTriggers: workflowTriggers
    workflowActions: workflowActions
    workflowOutputs: workflowOutputs
    workflowParameters: workflowParameters
    managedIdentities: managedIdentities
    integrationAccount: integrationAccount
    roleAssignments: roleAssignments
    diagnosticSettings: diagnosticSettings
    lock: lock
    tags: tags
    enableTelemetry: enableTelemetry
  }
}

output resourceId string = logicAppWorkflow.outputs.resourceId
output name string = logicAppWorkflow.outputs.name
output location string = logicAppWorkflow.outputs.location
output resourceGroupName string = logicAppWorkflow.outputs.resourceGroupName
output systemAssignedPrincipalId string = logicAppWorkflow.outputs.?systemAssignedMIPrincipalId ?? ''
