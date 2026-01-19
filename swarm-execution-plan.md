# Swarm Execution Plan: Parameter Table Documentation

## Objective
Ensure all module README files have complete parameter documentation tables that accurately reflect all parameters defined in their corresponding main.bicep files.

## Task Analysis
All 27 modules are independent - no cross-dependencies exist. Each task involves:
1. Read the module's main.bicep file to extract all parameters
2. Check the README.md for a parameters table
3. Update/create a complete parameter table with: name, type, default value, and description
4. Ensure table format is consistent with Markdown standards

## Wave Structure

### Wave 1: AI Modules (3 tasks)
- Task 1.1: ai/cognitive-services-account
- Task 1.2: ai/machine-learning-workspace  
- Task 1.3: ai/search-service

### Wave 2: Compute Modules (2 tasks)
- Task 2.1: compute/app-service
- Task 2.2: compute/app-service-plan

### Wave 3: Container Modules (2 tasks)
- Task 3.1: containers/container-app
- Task 3.2: containers/container-apps-environment

### Wave 4: Data Modules (5 tasks)
- Task 4.1: data/cosmos-db-account
- Task 4.2: data/postgresql-flexible-server
- Task 4.3: data/redis-cache
- Task 4.4: data/service-bus-namespace
- Task 4.5: data/sql-server

### Wave 5: Monitoring Modules (2 tasks)
- Task 5.1: monitoring/application-insights
- Task 5.2: monitoring/log-analytics-workspace

### Wave 6: Network Modules Part 1 (4 tasks)
- Task 6.1: network/azure-firewall
- Task 6.2: network/bastion-host
- Task 6.3: network/ddos-protection-plan
- Task 6.4: network/dns-resolver

### Wave 7: Network Modules Part 2 (4 tasks)
- Task 7.1: network/network-security-group
- Task 7.2: network/private-dns-zone
- Task 7.3: network/private-endpoint
- Task 7.4: network/virtual-network

### Wave 8: Network Modules Part 3 (1 task)
- Task 8.1: network/vpn-gateway

### Wave 9: Security Modules (2 tasks)
- Task 9.1: security/key-vault
- Task 9.2: security/managed-identity

### Wave 10: Storage Modules (2 tasks)
- Task 10.1: storage/container-registry
- Task 10.2: storage/storage-account

## Acceptance Criteria
For each module:
- ✅ README.md contains a "Parameters" section
- ✅ Parameters are documented in a Markdown table format
- ✅ Table includes columns: Parameter, Type, Default, Description
- ✅ All parameters from main.bicep are documented
- ✅ Parameter decorators (@description, @allowed, etc.) are captured
- ✅ Consistent formatting across all modules
