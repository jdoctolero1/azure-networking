param (
    [string]$Environment   = "lab",
    [string]$PrimaryRegion = "centralus",
    [string]$DrRegion      = "eastus"
)

Write-Host "[INFO] What if $Environment network resources in Primary Region: $PrimaryRegion is deployed"
az deployment sub what-if `
  --name deploy-network-$PrimaryRegion-$(Get-Date -Format 'yyyyMMddHHmm') `
  --location $PrimaryRegion `
  --template-file ./infra/main.bicep `
  --parameters ./environments/$Environment/primary.bicepparam

Write-Host "[INFO] What if $Environment network resources in Disaster Recovery Region: $DrRegion is deployed"
az deployment sub what-if `
  --name deploy-network-$DrRegion-$(Get-Date -Format 'yyyyMMddHHmm') `
  --location $DrRegion `
  --template-file ./infra/main.bicep `
  --parameters ./environments/$Environment/dr.bicepparam

Write-Host "[INFO] What if $Environment VNet Peering from Primary to DR region is deployed"
az deployment sub what-if `
  --name deploy-$Environment-network-peering-$(Get-Date -Format 'yyyyMMddHHmm') `
  --location $PrimaryRegion `
  --template-file ./infra/peering.bicep `
  --parameters environment=$Environment primaryLocation=$PrimaryRegion drLocation=$DrRegion