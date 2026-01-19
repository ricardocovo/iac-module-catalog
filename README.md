# Infrastructure as Code Module Catalog

Pre-approved Bicep module catalog for deploying Microsoft Foundry landing zone architectures with enterprise security and compliance.

## 🎯 Overview

This catalog provides production-ready, validated Bicep modules for enterprise Azure deployments. All modules are designed for:

- **Canadian FSI Security Compliance** - Private endpoints, RBAC, encryption at rest/in transit
- **Enterprise Scale** - Zone redundancy, high availability, multi-region support
- **AI Workloads** - Optimized for Microsoft Foundry, Azure OpenAI, and AI agent architectures
- **Governance** - Consistent naming, tagging, and resource organization

## 📦 Module Catalog

**Total: 27 modules across 8 categories**

| Category | Modules | Description |
|----------|---------|-------------|
| [Network](catalog/network/) | 9 | Hub-spoke networking, Azure Firewall, Bastion, VPN, DNS |
| [AI & ML](catalog/ai/) | 3 | Azure OpenAI, AI Search, Machine Learning Workspace |
| [Compute & Web](catalog/compute/) | 2 | App Service Plans, Web Apps |
| [Containers](catalog/containers/) | 2 | Container Apps Environment, Container Apps |
| [Data & Messaging](catalog/data/) | 5 | Redis, Cosmos DB, SQL, PostgreSQL, Service Bus |
| [Storage](catalog/storage/) | 2 | Storage Accounts, Container Registries |
| [Monitoring](catalog/monitoring/) | 2 | Log Analytics, Application Insights |
| [Security](catalog/security/) | 2 | Managed Identities, Key Vaults |

📖 **[View Module Details](catalog/README.md)**

## 🚀 Quick Start

### Prerequisites
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) installed
- [Bicep CLI](https://learn.microsoft.com/azure/azure-resource-manager/bicep/install) installed
- Azure subscription with appropriate permissions

### Deploy Your First Module

```bash
# Login to Azure
az login

# Set subscription
az account set --subscription "your-subscription-id"

# Deploy a Virtual Network
az deployment group create \
  --resource-group rg-foundry-canadacentral \
  --template-file catalog/network/virtual-network.bicep \
  --parameters \
    name=vnet-spoke-foundry-cac \
    location=canadacentral \
    addressPrefixes='["10.1.0.0/16"]' \
    subnets='[{"name":"app","addressPrefix":"10.1.1.0/24"}]'
```

### Using in Your Bicep Templates

Reference modules from this catalog:

```bicep
// Reference catalog module
module vnet './catalog/network/virtual-network.bicep' = {
  name: 'vnet-deployment'
  params: {
    name: 'vnet-hub-foundry-cac'
    location: 'canadacentral'
    addressPrefixes: ['10.0.0.0/16']
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        addressPrefix: '10.0.1.0/24'
      }
    ]
  }
}

// Reference another catalog module
module openai './catalog/ai/cognitive-services-account.bicep' = {
  name: 'openai-deployment'
  params: {
    name: 'oai-foundry-cac'
    kind: 'OpenAI'
    customSubDomainName: 'oai-foundry-cac'
    deployments: [
      {
        name: 'gpt-4o'
        model: {
          name: 'gpt-4o'
          version: '2024-08-06'
        }
        sku: {
          name: 'Standard'
          capacity: 10
        }
      }
    ]
  }
}
```

### Using Modules from Azure Container Registry

Modules are automatically published to Azure Container Registry via GitHub Actions. Reference them directly in your templates:

```bicep
// Reference module from ACR with specific version
module vnet 'br:myacr.azurecr.io/bicep/network/virtual-network:0.4.0' = {
  name: 'vnet-deployment'
  params: {
    name: 'vnet-hub-foundry-cac'
    location: 'canadacentral'
    addressPrefixes: ['10.0.0.0/16']
  }
}

// Or use major version tag (auto-updates to latest minor/patch)
module openai 'br:myacr.azurecr.io/bicep/ai/cognitive-services-account:v0' = {
  name: 'openai-deployment'
  params: {
    name: 'oai-foundry-cac'
    kind: 'OpenAI'
  }
}
```

🔧 **[Setup ACR Publishing](.github/workflows/README.md)** - Configure automatic module publishing

## 🏗️ Architecture

This catalog supports the **Baseline Microsoft Foundry Landing Zone** architecture:

```
┌─────────────────────────────────────────────────┐
│  Hub Virtual Network (Management)               │
│  ├─ Azure Firewall (Egress Filtering)           │
│  ├─ Azure Bastion (Secure Access)               │
│  ├─ VPN/ExpressRoute Gateway (Hybrid)           │
│  └─ DNS Private Resolver                        │
└─────────────────────────────────────────────────┘
                    │ Peering
┌─────────────────────────────────────────────────┐
│  Spoke Virtual Network (AI Workloads)           │
│  ├─ Application Subnet                          │
│  │  ├─ Container Apps                           │
│  │  └─ App Services (VNet Integrated)           │
│  ├─ Private Endpoint Subnet                     │
│  │  ├─ Azure OpenAI                             │
│  │  ├─ Azure AI Search                          │
│  │  ├─ Cosmos DB                                │
│  │  ├─ Redis Cache                              │
│  │  ├─ Storage Account                          │
│  │  └─ Key Vault                                │
│  └─ Data Subnet                                 │
│     ├─ PostgreSQL Flexible Server               │
│     └─ Azure SQL                                │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│  Shared Services (Regional/Global)              │
│  ├─ Private DNS Zones                           │
│  ├─ DDoS Protection Plan                        │
│  ├─ Log Analytics Workspace                     │
│  └─ Application Insights                        │
└─────────────────────────────────────────────────┘
```

📐 **[View Architecture Diagram](docs/architectures/baseline-microsoft-foundry-landing-zone.svg)**

## 🔒 Security & Compliance

### Canadian Financial Services Security

All modules implement security controls for Canadian FSI workloads:

- ✅ **Private Connectivity** - Private endpoints for all PaaS services
- ✅ **Network Isolation** - Public network access disabled by default
- ✅ **Identity & Access** - RBAC-based access, Azure AD authentication
- ✅ **Encryption** - TLS 1.2+ in transit, encryption at rest
- ✅ **High Availability** - Zone redundancy for Premium SKUs
- ✅ **Data Residency** - Canada Central and Canada East regions

See [Canadian FSI Security Instructions](.github/instructions/canadian-fsi-security.instructions.md)

### Best Practices

```bicep
// Always use private endpoints
privateEndpoints: [
  {
    subnetResourceId: peSubnetId
    privateDnsZoneResourceIds: [dnsZoneId]
  }
]

// Disable public access
publicNetworkAccess: 'Disabled'

// Use managed identity
managedIdentities: {
  systemAssigned: true
}

// Apply consistent tagging
tags: {
  environment: 'production'
  workload: 'foundry'
  dataClassification: 'confidential'
  costCenter: 'ai-platform'
}
```

## 🤖 AI Workload Patterns

### Conversational AI Application

```bicep
// 1. Deploy Container Apps Environment
module containerEnv 'catalog/containers/container-apps-environment.bicep' = {
  params: {
    name: 'cae-chat-cac'
    workspaceResourceId: logAnalytics.outputs.resourceId
    infrastructureSubnetId: appSubnetId
  }
}

// 2. Deploy Cosmos DB for chat history
module cosmosDb 'catalog/data/cosmos-db-account.bicep' = {
  params: {
    name: 'cosmos-chat-cac'
    sqlDatabases: [{
      name: 'conversations'
      containers: [{
        name: 'history'
        partitionKeyPath: '/userId'
      }]
    }]
  }
}

// 3. Deploy Redis for session state
module redis 'catalog/data/redis-cache.bicep' = {
  params: {
    name: 'redis-chat-cac'
    skuName: 'Premium'
  }
}

// 4. Deploy AI Services
module openai 'catalog/ai/cognitive-services-account.bicep' = {
  params: {
    name: 'oai-chat-cac'
    kind: 'OpenAI'
    deployments: [{
      name: 'gpt-4o'
      model: { name: 'gpt-4o', version: '2024-08-06' }
    }]
  }
}

// 5. Deploy Chat Application
module chatApp 'catalog/containers/container-app.bicep' = {
  params: {
    name: 'ca-chat-ui'
    environmentResourceId: containerEnv.outputs.resourceId
    containers: [{ name: 'chat', image: 'acr.azurecr.io/chat:latest' }]
  }
}
```

## 📚 Documentation

- **[Module Catalog](catalog/README.md)** - Complete list of all modules
- **[Network Modules](catalog/network/README.md)** - VNets, NSGs, Firewall, DNS
- **[AI Modules](catalog/ai/README.md)** - OpenAI, AI Search, ML Workspace
- **[Container Modules](catalog/containers/README.md)** - Container Apps
- **[Data Modules](catalog/data/README.md)** - Databases, cache, messaging
- **[Bicep Documentation](https://aka.ms/bicep)** - Microsoft Bicep reference

## 🛠️ Development

### Validating Modules

```bash
# Lint all modules
find catalog -name "*.bicep" -exec bicep lint {} \;

# Build modules (validate syntax)
find catalog -name "*.bicep" -exec bicep build {} --outfile /dev/null \;

# What-if deployment
az deployment group what-if \
  --resource-group rg-test \
  --template-file catalog/network/virtual-network.bicep \
  --parameters @test/parameters.json
```

### Adding New Modules

1. Follow [Bicep Best Practices](.github/instructions/bicep-code-best-practices.instructions.md)
2. Create module using Azure resource providers
3. Include comprehensive parameters with secure decorators
4. Add usage examples in category README
5. Update module count in catalog README

## 🌊 Deployment Patterns

### Wave-Based Deployment

Deploy foundation services first, then dependent resources:

**Wave 0 - Foundation**
```bash
# Monitoring
az deployment group create --template-file catalog/monitoring/log-analytics-workspace.bicep

# Identity
az deployment group create --template-file catalog/security/managed-identity.bicep
```

**Wave 1-3 - Networking**
```bash
# Hub VNet with Firewall
az deployment group create --template-file catalog/network/virtual-network.bicep
az deployment group create --template-file catalog/network/azure-firewall.bicep

# Spoke VNet with peering
az deployment group create --template-file catalog/network/virtual-network.bicep
az deployment group create --template-file catalog/network/virtual-network-peering.bicep
```

**Wave 4-6 - Workload Resources**
```bash
# Data tier
az deployment group create --template-file catalog/data/cosmos-db-account.bicep
az deployment group create --template-file catalog/data/redis-cache.bicep

# AI tier
az deployment group create --template-file catalog/ai/cognitive-services-account.bicep
az deployment group create --template-file catalog/ai/search-service.bicep

# Compute tier
az deployment group create --template-file catalog/containers/container-apps-environment.bicep
az deployment group create --template-file catalog/containers/container-app.bicep
```

## 🔄 Version Management

All modules are version controlled in this repository and published to Azure Container Registry:

### Local Development

```bicep
// Reference catalog modules with relative paths
module example './catalog/<category>/<module>/main.bicep'
```

### Production via ACR

```bicep
// Use published modules from Azure Container Registry
module example 'br:myacr.azurecr.io/bicep/<category>/<module>:<version>' = {
  name: 'deployment-name'
  params: { /* ... */ }
}
```

### CI/CD Publishing

The [GitHub Actions workflow](.github/workflows/README.md) automatically publishes modules to ACR when:
- Changes are pushed to `main` branch
- Any `main.bicep` file in `catalog/` is modified
- Version is extracted from AVM module reference
- Only new versions are published (existing versions are skipped)

**Repository Naming Convention:** `bicep/{category}/{module-name}:{version}`

📖 **[Full Setup Guide](.github/workflows/README.md)**

## 📊 Module Statistics

- **Total Modules**: 27
- **Categories**: 8
- **Azure Services**: 20+ Azure resource types
- **Lines of Code**: ~2,000 LOC
- **Security Patterns**: 100% private endpoint support

## 🤝 Contributing

This catalog follows enterprise Bicep standards. When contributing:

1. Create modules using Azure resource providers
2. Follow Canadian FSI security requirements
3. Include comprehensive parameter documentation
4. Add usage examples and test parameters
5. Update category and main READMEs

## 📄 License

This project contains enterprise Bicep module templates for Azure infrastructure deployment.

## 🆘 Support

- **Bicep Issues**: [Azure/bicep](https://github.com/Azure/bicep/issues)
- **Azure Documentation**: [Microsoft Azure Docs](https://learn.microsoft.com/azure/)
- **Bicep Documentation**: [Bicep Reference](https://aka.ms/bicep)

## 🗺️ Roadmap

- [ ] Add Event Grid module for event-driven architectures
- [ ] Include Container Apps Jobs for batch processing
- [ ] Add API Management module for API gateway
- [ ] Create Azure Monitor Private Link Scope module
- [ ] Develop sample end-to-end deployment orchestration
- [ ] Add cost estimation documentation per module

---

**Last Updated**: January 2026 | **Modules**: 27 | **Status**: Production Ready 
