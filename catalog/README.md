# Azure Modules Catalog

This catalog provides validated Bicep module implementations for enterprise Azure deployments.

## Module Categories

### 📡 [Network Modules](network/)
Hub-spoke networking, security, and connectivity services
- Virtual Networks (hub/spoke topology)
- Network Security Groups
- Private Endpoints & DNS Zones
- Azure Firewall, Bastion, VPN Gateway
- DDoS Protection & DNS Resolver

**Total: 9 modules**

### 🤖 [AI & Machine Learning Modules](ai/)
AI services for Microsoft Foundry workloads
- Azure AI Search (vector + full-text)
- Azure OpenAI / Cognitive Services
- Azure ML Workspace (Foundry)

**Total: 3 modules**

### 💻 [Compute & Web Modules](compute/)
Application hosting and web services
- App Service Plans
- App Services (Web Apps)

**Total: 2 modules**

### 💾 [Storage Modules](storage/)
Data storage and container management
- Storage Accounts
- Container Registries

**Total: 2 modules**

### 📊 [Monitoring Modules](monitoring/)
Observability and diagnostics
- Log Analytics Workspaces
- Application Insights

**Total: 2 modules**

### 🔐 [Security Modules](security/)
Identity and secrets management
- Managed Identities
- Key Vaults

**Total: 2 modules**

### 📦 [Container Modules](containers/)
Containerized application hosting
- Container Apps Environment
- Container Apps

**Total: 2 modules**

### 🗄️ [Data & Messaging Modules](data/)
Data persistence and message broker services
- Azure Cache for Redis
- Cosmos DB
- Azure SQL Server
- PostgreSQL Flexible Server
- Service Bus

**Total: 5 modules**

## Canadian FSI Security Compliance

All modules follow security best practices per [canadian-fsi-security.instructions.md](../.github/instructions/canadian-fsi-security.instructions.md):
- Private endpoints enabled by default
- Public network access disabled where applicable
- RBAC-based access control
- Network isolation and encryption
- Canadian data residency support (Canada Central, Canada East regions)

## Best Practices

### Parameter Patterns
Use consistent naming and tagging:
```bicep
{
  name: '<prefix>-<workload>-<region>'
  location: 'canadacentral'
  tags: {
    environment: 'production'
    workload: 'foundry'
    dataClassification: 'confidential'
  }
}
```

### Private Connectivity
Always deploy with private endpoints:
```bicep
privateEndpoints: [
  {
    subnetResourceId: peSubnetId
    privateDnsZoneResourceIds: [dnsZoneId]
  }
]
```

## Module Development

### Linting
Run Bicep lint on all modules:
```bash
find catalog -name "*.bicep" -exec bicep lint {} \;
```

### Testing
Validate module deployments:
```bash
az deployment group what-if \
  --resource-group rg-test \
  --template-file catalog/network/virtual-network.bicep \
  --parameters @parameters.json
```

## Contributing

When adding new modules:
1. Use Azure AVM Bicep agent to ensure instructions and Bicep best practices are followed.
2. Create validated module implementations
3. Include comprehensive parameters
4. Add usage examples
5. Update category README

## Resources

- [Bicep Documentation](https://aka.ms/bicep)
- [Azure Documentation](https://learn.microsoft.com/azure/)

## Module Count Summary

**Total Modules: 27**
- Network: 9
- AI/ML: 3  
- Compute: 2
- Storage: 2
- Monitoring: 2
- Security: 2
- Containers: 2
- Data & Messaging: 5

All modules are production-ready and validated for enterprise use.
