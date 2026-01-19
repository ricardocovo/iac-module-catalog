# Monitoring Modules

Azure Verified Modules for monitoring and observability in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Version | Description |
|--------|--------------|---------|-------------|
| [Log Analytics Workspace](log-analytics-workspace.bicep) | `avm/res/operational-insights/workspace` | 0.7.0 | Log Analytics Workspace |
| [Application Insights](application-insights.bicep) | `avm/res/insights/component` | 0.4.0 | Application Insights |

## Usage Example

```bicep
module logAnalytics './log-analytics-workspace.bicep' = {
  name: 'law-deployment'
  params: {
    name: 'law-foundry-eastus2'
    location: 'eastus2'
    skuName: 'PerGB2018'
    dataRetention: 90
  }
}

module appInsights './application-insights.bicep' = {
  name: 'ai-deployment'
  params: {
    name: 'ai-foundry-eastus2'
    location: 'eastus2'
    workspaceResourceId: logAnalytics.outputs.resourceId
  }
}
```
