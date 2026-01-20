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

  #TODO: Add DR region deployment once Bicep modules are updated