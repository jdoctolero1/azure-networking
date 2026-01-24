param (
    [string]$PrimaryRegion = "centralus",
    [string]$DrRegion      = "eastus"
)

Write-Host "[INFO] Creating lab network resources in Primary Region: $PrimaryRegion"
az deployment sub create `
  --name deploy-network-$PrimaryRegion-$(Get-Date -Format 'yyyyMMddHHmm') `
  --location $PrimaryRegion `
  --template-file ./infra/main.bicep `
  --parameters ./environments/lab/primary.bicepparam

Write-Host "[INFO] Creating lab network resources in Disaster Recovery Region: $DrRegion"
az deployment sub create `
  --name deploy-network-$DrRegion-$(Get-Date -Format 'yyyyMMddHHmm') `
  --location $DrRegion `
  --template-file ./infra/main.bicep `
  --parameters ./environments/lab/dr.bicepparam

  Write-Host "[INFO] Creating VNet Peering from Primary to DR region"
  az deployment sub create `
  --location $PrimaryRegion `
  --template-file ./infra/peering.bicep `
  --parameters environment='lab' primaryLocation=$PrimaryRegion drLocation=$DrRegion