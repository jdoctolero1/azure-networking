## Deployment Scripts

This folder contains helper scripts to deploy the networking Bicep templates. The primary helper is `deploy-network.ps1`, which runs two subscription-scoped deployments (Primary and DR) using the `lab` environment parameter files.

What the script does
- Runs `az deployment sub create` twice: once for the primary region and once for the DR region.
- Uses `infra/main.bicep` as the template and the `environments/lab/*.bicepparam` files for parameters.

Parameters
- `PrimaryRegion` (default `centralus`) — Azure location for the primary deployment.
- `DrRegion` (default `eastus`) — Azure location for the DR deployment.

Example (PowerShell)

```powershell
# Run with defaults
./scripts/deploy-network.ps1

# Run with custom regions
./scripts/deploy-network.ps1 -PrimaryRegion westus2 -DrRegion eastus2
```

Adding other environments
- The script currently points to the `lab` parameter files (`environments/lab/primary.bicepparam` and `environments/lab/dr.bicepparam`). You may modify the script to use other environment folders (for example `environments/dev`) or add new parameter-file arguments to the script to support multiple environments.

Notes & troubleshooting
- Ensure you're logged in with `az login` and your subscription context is set (if required) before running the script.
- The script uses subscription-scoped deployments (`az deployment sub create`) — confirm you have sufficient permissions to deploy at subscription scope.
- To run deployments for a single region only, edit the script to remove the second `az deployment` call or run the command manually with the desired parameter file.