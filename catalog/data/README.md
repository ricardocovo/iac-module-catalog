# Data & Messaging Modules

Azure Verified Modules for data persistence and messaging services in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Azure Cache for Redis](redis-cache/) | `avm/res/cache/redis` | [0.16.0](redis-cache/0.16.0/) \| [0.16.1](redis-cache/0.16.1/) \| [0.16.2](redis-cache/0.16.2/) \| [0.16.3](redis-cache/0.16.3/) \| [0.16.4](redis-cache/0.16.4/) | In-memory data store for caching |
| [Cosmos DB](cosmos-db-account/) | `avm/res/document-db/database-account` | [0.15.0](cosmos-db-account/0.15.0/) \| [0.15.1](cosmos-db-account/0.15.1/) \| [0.16.0](cosmos-db-account/0.16.0/) \| [0.17.0](cosmos-db-account/0.17.0/) \| [0.18.0](cosmos-db-account/0.18.0/) | Globally distributed NoSQL database |
| [Azure SQL Server](sql-server/) | `avm/res/sql/server` | [0.20.1](sql-server/0.20.1/) \| [0.20.2](sql-server/0.20.2/) \| [0.20.3](sql-server/0.20.3/) \| [0.21.0](sql-server/0.21.0/) \| [0.21.1](sql-server/0.21.1/) | Relational database service |
| [PostgreSQL Flexible Server](postgresql-flexible-server/) | `avm/res/db-for-postgre-sql/flexible-server` | [0.13.1](postgresql-flexible-server/0.13.1/) \| [0.13.2](postgresql-flexible-server/0.13.2/) \| [0.14.0](postgresql-flexible-server/0.14.0/) \| [0.15.0](postgresql-flexible-server/0.15.0/) \| [0.15.1](postgresql-flexible-server/0.15.1/) | Open-source relational database |
| [Service Bus](service-bus-namespace/) | `avm/res/service-bus/namespace` | [0.14.0](service-bus-namespace/0.14.0/) \| [0.14.1](service-bus-namespace/0.14.1/) \| [0.15.0](service-bus-namespace/0.15.0/) \| [0.15.1](service-bus-namespace/0.15.1/) \| [0.16.0](service-bus-namespace/0.16.0/) | Enterprise message broker |

## Usage Examples

### Redis Cache
```bicep
module redis './redis-cache.bicep' = {
  name: 'redis-deployment'
  params: {
    name: 'redis-foundry-eastus2'
    location: 'eastus2'
    skuName: 'Premium'
    skuCapacity: 1
    publicNetworkAccess: 'Disabled'
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [redisDnsZoneId]
      }
    ]
    zones: ['1', '2', '3']
  }
}
```

### Cosmos DB (NoSQL API)
```bicep
module cosmosDb './cosmos-db-account.bicep' = {
  name: 'cosmos-deployment'
  params: {
    name: 'cosmos-foundry-eastus2'
    location: 'eastus2'
    kind: 'GlobalDocumentDB'
    defaultConsistencyLevel: 'Session'
    publicNetworkAccess: 'Disabled'
    sqlDatabases: [
      {
        name: 'chathistory'
        containers: [
          {
            name: 'conversations'
            partitionKeyPath: '/userId'
          }
        ]
      }
    ]
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [cosmosDnsZoneId]
      }
    ]
  }
}
```

### Azure SQL Database
```bicep
module sqlServer './sql-server.bicep' = {
  name: 'sql-deployment'
  params: {
    name: 'sql-foundry-eastus2'
    location: 'eastus2'
    administratorLogin: 'sqladmin'
    administratorLoginPassword: adminPassword
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
    databases: [
      {
        name: 'appdb'
        skuName: 'S0'
        skuTier: 'Standard'
      }
    ]
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [sqlDnsZoneId]
      }
    ]
  }
}
```

### PostgreSQL Flexible Server
```bicep
module postgresql './postgresql-flexible-server.bicep' = {
  name: 'psql-deployment'
  params: {
    name: 'psql-foundry-eastus2'
    location: 'eastus2'
    version: '16'
    skuName: 'Standard_D2ds_v4'
    storageSizeGB: 128
    administratorLogin: 'pgadmin'
    administratorLoginPassword: adminPassword
    highAvailability: 'ZoneRedundant'
    publicNetworkAccess: 'Disabled'
    delegatedSubnetResourceId: dbSubnetId
    privateDnsZoneResourceId: psqlDnsZoneId
    databases: [
      {
        name: 'appdb'
        charset: 'UTF8'
      }
    ]
  }
}
```

### Service Bus
```bicep
module serviceBus './service-bus-namespace.bicep' = {
  name: 'sb-deployment'
  params: {
    name: 'sb-foundry-eastus2'
    location: 'eastus2'
    skuName: 'Premium'
    capacity: 1
    zoneRedundant: true
    publicNetworkAccess: 'Disabled'
    queues: [
      {
        name: 'requests'
        maxDeliveryCount: 10
      }
    ]
    topics: [
      {
        name: 'events'
        subscriptions: [
          {
            name: 'processor'
          }
        ]
      }
    ]
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [sbDnsZoneId]
      }
    ]
  }
}
```

## Data Platform Patterns

### Chat History Store (Cosmos DB)
- Use hierarchical partition keys: `/tenantId/userId`
- Enable automatic indexing for queries
- Consider change feed for real-time processing

### Session State (Redis)
- Use Premium tier for VNet integration
- Enable data persistence for critical data
- Configure TTL for automatic cleanup

### Relational Data (SQL/PostgreSQL)
- Use zone-redundant configuration
- Enable automated backups
- Consider read replicas for scale-out

### Async Processing (Service Bus)
- Use topics for pub/sub patterns
- Configure dead-letter queues
- Enable duplicate detection for idempotency
