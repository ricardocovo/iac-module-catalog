// Azure Verified Module Reference: Logic App Workflow
// Registry: br/public:avm/res/logic/workflow

metadata name = 'Logic App Workflow'
metadata description = 'AVM reference for deploying Azure Logic Apps Workflow'
metadata owner = 'Azure Verified Modules'

@description('The name of the Logic App workflow')
@minLength(1)
@maxLength(80)
param name string

@description('The location for the Logic App workflow')
param location string = resourceGroup().location

@description('The state of the workflow. Default is Enabled.')
@allowed(['NotSpecified', 'Completed', 'Enabled', 'Disabled', 'Deleted', 'Suspended'])
param state string = 'Enabled'

@description('The definitions for one or more triggers that instantiate your workflow')
param workflowTriggers object = {}

@description('The definitions for one or more actions to execute at workflow runtime')
param workflowActions object = {}

@description('The definitions for the outputs to return from a workflow run')
param workflowOutputs object = {}

@description('The definitions for one or more parameters that pass the values to use at your logic apps runtime')
param workflowParameters object = {}

@description('Parameters for the definition template')
param definitionParameters object = {}

@description('The managed identity definition for this resource')
param managedIdentities object = {}

@description('The integration account configuration')
param integrationAccount object = {}

@description('The integration service environment settings')
param integrationServiceEnvironment object = {}

@description('The access control configuration for workflow actions')
param actionsAccessControlConfiguration object = {}

@description('The access control configuration for accessing workflow run contents')
param contentsAccessControlConfiguration object = {}

@description('The access control configuration for invoking workflow triggers')
param triggersAccessControlConfiguration object = {}

@description('The access control configuration for workflow management')
param workflowManagementAccessControlConfiguration object = {}

@description('The diagnostic settings of the service')
param diagnosticSettings array = []

@description('The lock settings of the service')
param lock object = {}

@description('Array of role assignments to create')
param roleAssignments array = []

@description('Tags of the resource')
param tags object = {}

@description('Enable/Disable usage telemetry for module')
param enableTelemetry bool = true

module logicAppWorkflow 'br/public:avm/res/logic/workflow:0.5.0' = {
  name: take('${name}-deploy', 64)
  params: {
    name: name
    location: location
    state: state
    workflowTriggers: workflowTriggers
    workflowActions: workflowActions
    workflowOutputs: workflowOutputs
    workflowParameters: workflowParameters
    definitionParameters: definitionParameters
    managedIdentities: managedIdentities
    integrationAccount: integrationAccount
    integrationServiceEnvironment: integrationServiceEnvironment
    actionsAccessControlConfiguration: actionsAccessControlConfiguration
    contentsAccessControlConfiguration: contentsAccessControlConfiguration
    triggersAccessControlConfiguration: triggersAccessControlConfiguration
    workflowManagementAccessControlConfiguration: workflowManagementAccessControlConfiguration
    diagnosticSettings: diagnosticSettings
    lock: lock
    roleAssignments: roleAssignments
    tags: tags
    enableTelemetry: enableTelemetry
  }
}

@description('The name of the Logic App workflow')
output name string = logicAppWorkflow.outputs.name

@description('The resource ID of the Logic App workflow')
output resourceId string = logicAppWorkflow.outputs.resourceId

@description('The resource group the Logic App workflow was deployed into')
output resourceGroupName string = logicAppWorkflow.outputs.resourceGroupName

@description('The location the Logic App workflow was deployed into')
output location string = logicAppWorkflow.outputs.location

@description('The principal ID of the system assigned identity')
output systemAssignedMIPrincipalId string = logicAppWorkflow.outputs.?systemAssignedMIPrincipalId ?? ''
