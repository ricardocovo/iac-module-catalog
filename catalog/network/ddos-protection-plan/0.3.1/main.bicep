// Azure Verified Module Reference: DDoS Protection Plan
// Registry: br/public:avm/res/network/ddos-protection-plan

metadata name = 'DDoS Protection Plan'
metadata description = 'AVM reference for deploying Azure DDoS Protection Plan'
metadata owner = 'Azure Verified Modules'

@description('The name of the DDoS protection plan')
param name string

@description('The location for the plan')
param location string = resourceGroup().location

@description('Tags for the resource')
param tags object = {}

module ddosProtectionPlan 'br/public:avm/res/network/ddos-protection-plan:0.3.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    tags: tags
  }
}

output resourceId string = ddosProtectionPlan.outputs.resourceId
output name string = ddosProtectionPlan.outputs.name
