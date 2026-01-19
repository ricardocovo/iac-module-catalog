# Swarm Mode Plan: Restructure Catalog Modules

## Objective
Restructure all 27 modules in `/catalog` to follow "Writing Modules" standards:
- Each module in its own folder
- Module file named `main.bicep`
- Include `README.md` with documentation
- Add `examples/` folder with example files

## Current Structure
All modules are single `.bicep` files in category folders.

## Target Structure
```
catalog/
  {category}/
    {module-name}/
      main.bicep
      README.md
      examples/
        example1.bicep
        example2.bicep
```

## Dependency Analysis
All tasks are independent restructuring operations - can be fully parallelized.

## Wave Organization

### Wave 0: AI Category (3 modules)
- Task 1: cognitive-services-account
- Task 2: machine-learning-workspace  
- Task 3: search-service

### Wave 1: Compute Category (2 modules)
- Task 4: app-service-plan
- Task 5: app-service

### Wave 2: Containers Category (2 modules)
- Task 6: container-app
- Task 7: container-apps-environment

### Wave 3: Data Category (5 modules)
- Task 8: cosmos-db-account
- Task 9: postgresql-flexible-server
- Task 10: redis-cache
- Task 11: service-bus-namespace
- Task 12: sql-server

### Wave 4: Monitoring Category (2 modules)
- Task 13: application-insights
- Task 14: log-analytics-workspace

### Wave 5: Network Category (9 modules)
- Task 15: azure-firewall
- Task 16: bastion-host
- Task 17: ddos-protection-plan
- Task 18: dns-resolver
- Task 19: network-security-group
- Task 20: private-dns-zone
- Task 21: private-endpoint
- Task 22: virtual-network
- Task 23: vpn-gateway

### Wave 6: Security Category (2 modules)
- Task 24: key-vault
- Task 25: managed-identity

### Wave 7: Storage Category (2 modules)
- Task 26: container-registry
- Task 27: storage-account

## Task Template (for each module)

### Actions Required:
1. Read current `.bicep` file content
2. Create new folder structure: `catalog/{category}/{module-name}/`
3. Move/rename `.bicep` to `main.bicep` in new folder
4. Create `README.md` with:
   - Module description
   - Parameters table
   - Usage examples
   - References to example files
5. Create `examples/` folder with 2-3 example `.bicep` files
6. Run `bicep lint` on `main.bicep` to validate
7. Commit changes with message: "Restructure {category}/{module-name} module"

## Success Criteria
- All 27 modules restructured
- Each has `main.bicep`, `README.md`, and `examples/`
- All pass `bicep lint`
- Git history preserved with clear commits

## Approval Policy
- Auto-merge when lint passes and no conflicts detected
- Pause on lint errors or merge conflicts
