## Environments

This folder contains environment specific parameter files used by the top-level Bicep deployments.

Provided environments
- `lab` — A ready-to-use environment for testing and learning. It includes parameter files such as `primary.bicepparam` and `dr.bicepparam` that configure the resource groups, vnets, tags, etc.

Adding other environments
- You may add additional environments (for example: `dev`, `stg`, `prd`) by creating a new subfolder under `environments/` and adding one or more `.bicepparam` files. Keep naming consistent and document any environment-specific differences.

Usage
- When building a new environment you can add an entry to the deploy-network.ps1 script or create a new powershell script under the scripts directory. Example:

```powershell
# A script for deploying a staging environment
az deployment sub create `
  --name deploy-network-$PrimaryRegion-$(Get-Date -Format 'yyyyMMddHHmmss') `
  --location $PrimaryRegion `
  --template-file ../infra/main.bicep `
  --parameters ../environments/$Environment$/primary.bicepparambicepparam
```

Notes
- Parameter files should follow the parameter names expected by `infra/main.bicep` (for example: `environment`, `addressPrefix`, `subnets`, `tags`, `vnetLock`).
- Keep environment parameter files under version control and review changes in pull requests.

