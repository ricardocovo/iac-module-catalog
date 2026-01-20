---
description: "Create, update, or review Azure IaC in Bicep using Azure Verified Modules (AVM)."
name: "Azure AVM Bicep mode"
tools: ['vscode', 'execute/getTerminalOutput', 'execute/runTask', 'execute/createAndRunTask', 'execute/runInTerminal', 'execute/runTests', 'execute/testFailure', 'read/terminalSelection', 'read/terminalLastCommand', 'read/getTaskOutput', 'read/problems', 'read/readFile', 'com.microsoft/azure/search', 'edit/editFiles', 'search', 'web']
---

# Azure AVM Bicep mode

Use Azure Verified Modules for Bicep to enforce Azure best practices via pre-built modules.

## Discover modules

- AVM Index: `https://azure.github.io/Azure-Verified-Modules/indexes/bicep/bicep-resource-modules/`
- GitHub: `https://github.com/Azure/bicep-registry-modules/tree/main/avm/`

## Usage

- **Examples**: Copy from module documentation, update parameters, pin version
- **Registry**: Reference `br/public:avm/res/{service}/{resource}:{version}`

## Versioning

- MCR Endpoint: `https://mcr.microsoft.com/v2/bicep/avm/res/{service}/{resource}/tags/list`
- Pin to specific version tag

## Sources

- GitHub: `https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/{service}/{resource}`
- Registry: `br/public:avm/res/{service}/{resource}:{version}`

## Naming conventions

- Resource: avm/res/{service}/{resource}
- Pattern: avm/ptn/{pattern}
- Utility: avm/utl/{utility}

## Best practices

- Always use AVM modules where available
- Pin module versions
- Start with official examples
- Review module parameters and outputs
- Always run `bicep lint` after making changes
- Use `azure_get_deployment_best_practices` tool for deployment guidance
- Use `azure_get_schema_for_Bicep` tool for schema validation
- Use `microsoft.docs.mcp` tool to look up Azure service-specific guidance

## Writing modules

When writing modules, follow this guidelines:

- Follow Azure AVM Bicep best practices
- Follow categories described on best practices
- Each module can have multiple versions
- Each module version should be on its own folder
  - Module file will be named `main.bicep`
  - Include `README.md` with documentation of module and description of the  examples.
  - The `README.md` should have a table describing the parameters and outputs of the module.

Example:
```
catalog/
  storage/
    storage-account/
      0.14.0/
        examples/
          example1.bicep
          example2.bicep
        main.bicep
        README.md
``` 