# Modules

This folder contains reusable Bicep modules used by the top-level deployments in `infra/`.

Overview
- `rg/` — module that creates a subscription-scoped Resource Group and applies a delete lock.
- `vnet/` — module that deploys a Virtual Network and its subnets into a resource group (expects a `scope` when called).
- `vnet-peering/` — module that deploys VNet Peering betwen the Primary and DR VNets.

Conventions
- Modules accept well-named parameters (for example: `name`, `location`, `tags`, `lock`, `subnets`) and expose outputs where applicable.
- Locks: some modules accept a `lock` object with at least `name` and `kind` (e.g., `CanNotDelete`) which the caller can pass from parameter files.

Per-module notes
- `rg/main.bicep`
	- Target scope: `subscription`.
	- Parameters: `resourceGroupName`, `tags`.
	- Behavior: creates a resource group and applies a resource-level delete lock (see `infra/main.bicep` for example usage).

- `vnet/main.bicep`
	- Target scope: resource group (the caller sets `scope: resourceGroup(resourceGroupName)`).
	- Parameters: `location`, `vnetName`, `addressPrefixes`, `subnets`, `tags`, and an optional `lock` object.
	- Behavior: deploys the virtual network using a reusable public module and forwards `lock` through to that module.

- `vnet-peering/main.bicep`
    - Target scope: resource group (caller sets `scope` to the resource group containing one of the VNets; for peering, 
    - Parameters: `localVnetName`, `remoteVnetId`, `peeringName`
    - Behavior: creates/updates VNet peering one way

Example usage (from `infra/main.bicep`)

```bicep
module rg '../modules/rg/main.bicep' = {
	name: 'rg'
	params: {
		resourceGroupName: resourceGroupName
		tags: tags
	}
}

module vnet '../modules/vnet/main.bicep' = {
	name: 'vnet'
	scope: resourceGroup(resourceGroupName)
	dependsOn: [ rg ]
	params: {
		addressPrefixes: addressPrefix
		vnetName: vnetName
		location: location
		lock: vnetLock
		subnets: subnets
		tags: tags
	}
}

```

How to extend
- Add new modules as subfolders with a `main.bicep` and a small `README.md` describing parameters and outputs.
- Keep modules focused and idempotent; prefer parameter-driven behavior over in-module branching.

Troubleshooting
- If a module fails to deploy, validate parameter shapes and types with `bicep build` and test the module locally with a small parameter file.
- Ensure scopes match module expectations (`targetScope = 'subscription'` vs resource-group scoped modules).