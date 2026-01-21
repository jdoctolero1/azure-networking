param (
    [string]$PrimaryRegion = "centralus",
    [string]$DrRegion      = "eastus"
)

Write-Host "[INFO] Creating lab network resources in Primary Region: $PrimaryRegion"
az deployment sub create `
  --name deploy-network-$PrimaryRegion-$(Get-Date -Format 'yyyyMMddHHmmss') `
  --location $PrimaryRegion `
  --template-file ../infra/main.bicep `
  --parameters ../environments/lab/primary.bicepparam

Write-Host "[INFO] Creating lab network resources in Disaster Recovery Region: $DrRegion"
az deployment sub create `
  --name deploy-network-$DrRegion-$(Get-Date -Format 'yyyyMMddHHmmss') `
  --location $DrRegion `
  --template-file ../infra/main.bicep `
  --parameters ../environments/lab/dr.bicepparam