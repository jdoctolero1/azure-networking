# Infra — Network Deployment (Bicep)

## Overview

This folder contains the top-level Bicep file used to deploy the networking infrastructure for this lab. The main entry is `main.bicep` which references reusable modules in `../modules` to create resource groups, virtual networks, and related resources.

## Files

- `main.bicep` — Top-level deployment in this folder.
- `../modules/rg/main.bicep` — Resource group module.
- `../modules/vnet/main.bicep` — Virtual network module.
- `../environments/lab/primary.bicepparam` — Primary parameter file for the lab environment.
- `../environments/lab/dr.bicepparam` — DR parameter file for the lab environment.
- `../scripts/deploy-network.ps1` — PowerShell helper script to run the deployment.
- `peering.bicep` — Creates VNet peering post VNet deployment.
- `../modules/vnet-peering/main.bicep` — Virtual network peering.

## Prerequisites

- Azure CLI (recommended) or Portal access.
- Bicep CLI (or use the Azure CLI's integrated Bicep support).
- PowerShell (if using `deploy-network.ps1`).

Install examples:

```powershell
# Azure CLI
az login

# (Optional) Install Bicep CLI
az bicep install
```

## Deploy

Recommended: use the PowerShell helper script from the repo root.

```powershell
# from repository root
.
\scripts\deploy-network.ps1 -Environment lab -ParameterFile .\environments\lab\primary.bicepparam -Location eastus
```

Alternatively, use `az deployment` directly:

```powershell
az deployment sub create --template-file infra\main.bicep --location eastus --parameters @environments\lab\primary.bicepparam
```

Adjust the `--location` and parameter file as needed (use `dr.bicepparam` for DR scenarios).

## Parameters

Parameter files live under `environments/lab/`. Review those files to change address spaces, tags, and resource naming.

## Customization

- Add or modify modules under `modules/` to extend the deployment.
- Update parameter files in `environments/` to change environment-specific values.

## Troubleshooting

- If Bicep compilation fails, ensure the Bicep CLI version is current: `az bicep version`.
- For authorization errors, run `az login` and confirm subscription context with `az account show`.

## License

See the repository root `LICENSE` for licensing information.
