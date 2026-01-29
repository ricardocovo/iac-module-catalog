# Monitoring Modules

Azure Verified Modules for monitoring and observability in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Log Analytics Workspace](log-analytics-workspace/) | `avm/res/operational-insights/workspace` | [0.13.0](log-analytics-workspace/0.13.0/) \| [0.14.0](log-analytics-workspace/0.14.0/) \| [0.14.1](log-analytics-workspace/0.14.1/) \| [0.14.2](log-analytics-workspace/0.14.2/) \| [0.15.0](log-analytics-workspace/0.15.0/) | Log Analytics Workspace |
| [Application Insights](application-insights/) | `avm/res/insights/component` | [0.5.0](application-insights/0.5.0/) \| [0.6.0](application-insights/0.6.0/) \| [0.6.1](application-insights/0.6.1/) \| [0.7.0](application-insights/0.7.0/) \| [0.7.1](application-insights/0.7.1/) | Application Insights |

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
