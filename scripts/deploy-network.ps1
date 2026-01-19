param (
    [string]$PrimaryRegion = "centralus",
    [string]$DrRegion      = "eastus"
)

az deployment sub create `
  --location $PrimaryRegion `
  --template-file ../modules/rg/main.bicep `
  --parameters ../environments/lab/main.bicepparam