# Azure Virtual Network
This repository contains Bicep templates for deploying a Primary and a Disaster Recovery **Azure Virtual Network (VNet)**. 

## Prerequisites

- Azure CLI Installed
- PowerShell

## Dependencies

This project uses Azure Verified Modules (AVM) for deploying Azure resources with Bicep.

For official module documentation and references, see the Bicep Registry Modules (AVM) repository:

https://github.com/Azure/bicep-registry-modules

---

## How to run it
This will use defaults of Primary Region = Central US and DR Region = East US
```powershell 
az login
./scripts/deploy-network.ps1
```

## Alternatively you can specify the Primary and DR Region

```powershell 
./scripts/deploy-network.ps1 -PrimaryRegion westus2 -DrRegion eastus2
```

## Resource Group and VNet Build
![Azure VNet Diagram](./docs/diagrams/Lab-Network-ResourceGroups.drawio.png)

## What gets deployed
- **Resource Groups**
- **Resource Group Delete Lock**
- **Virtual Networks (VNet)**
- **VNet Delete Lock**
- **Subnets**