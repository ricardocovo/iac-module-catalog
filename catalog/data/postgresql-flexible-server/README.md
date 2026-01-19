# PostgreSQL Flexible Server Module

## Overview

This module deploys an Azure PostgreSQL Flexible Server using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/db-for-postgre-sql/flexible-server:0.2.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

See [main.bicep](main.bicep) for the complete list of parameters and their descriptions.

## Outputs

This module returns the standard outputs from the underlying AVM module, typically including:
- `resourceId` - The resource ID
- `name` - The resource name
- Additional resource-specific outputs

## Usage

### Basic Deployment

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal configuration.

### Production Deployment

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready configuration.

## Example

```bicep
module postgresqlflexibleserver '../postgresql-flexible-server/main.bicep' = {
  name: 'postgresql-flexible-server-deployment'
  params: {
    name: 'my-postgresql-flexible-server'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/postgresql/)
- [Azure Verified Modules](https://aka.ms/avm)
