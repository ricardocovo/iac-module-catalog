// Azure Verified Module Reference: Container App Job
// Registry: br/public:avm/res/app/job

metadata name = 'Container App Job'
metadata description = 'AVM reference for deploying Azure Container App Jobs'
metadata owner = 'Azure Verified Modules'

@description('The name of the container app job')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Container Apps environment resource ID')
param environmentResourceId string

@description('Container configuration')
param containers array

@description('Trigger type for the job')
@allowed([
  'Manual'
  'Schedule'
  'Event'
])
param triggerType string

@description('Manual trigger configuration')
param manualTriggerConfig object = {}

@description('Schedule trigger configuration')
param scheduleTriggerConfig object = {}

@description('Event trigger configuration')
param eventTriggerConfig object = {}

@description('Replica timeout in seconds')
param replicaTimeout int = 1800

@description('Replica retry limit')
param replicaRetryLimit int = 0

@secure()
@description('Secrets configuration object')
param secretsConfiguration object = {}

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

@description('Registries for pulling container images')
param registries array = []

module job 'br/public:avm/res/app/job:0.7.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    environmentResourceId: environmentResourceId
    containers: containers
    triggerType: triggerType
    manualTriggerConfig: triggerType == 'Manual' ? manualTriggerConfig : null
    scheduleTriggerConfig: triggerType == 'Schedule' ? scheduleTriggerConfig : null
    eventTriggerConfig: triggerType == 'Event' ? eventTriggerConfig : null
    replicaTimeout: replicaTimeout
    replicaRetryLimit: replicaRetryLimit
    secrets: !empty(secretsConfiguration) ? secretsConfiguration.?secrets : []
    managedIdentities: managedIdentities
    tags: tags
    registries: registries
  }
}

@description('The resource ID of the job')
output resourceId string = job.outputs.resourceId

@description('The name of the job')
output name string = job.outputs.name

@description('The resource group the job was deployed into')
output resourceGroupName string = job.outputs.resourceGroupName

@description('The location the job was deployed into')
output location string = job.outputs.location
