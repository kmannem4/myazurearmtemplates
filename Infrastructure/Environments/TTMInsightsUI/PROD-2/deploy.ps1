# To run: open PowerShell, cd to the directory where this script is located, type .\deploy.ps1 and hit enter
# If using VS Code: right-click on the folder where this script is located, select Open in Terminal, in the terminal type .\deploy.ps1 and hit enter
cd 'BuildOutput\Artifacts\src\ARM\Infrastructure\Environments\TTMInsightsUI\PROD-2'

#Connect-AzAccount
Set-AzContext -Subscription 'AMN Shiftwise Prod'

$ResourceGroupName = 'amn-wcus-ttm-rg-p01'
$ResourceGroupLocation = 'westcentralus'
$storageAccountName = "amnttminsightssap02"

# Create or update the resource group using the specified template file and template parameters file
New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

#Location on personal drive. Should update to reference URI in DevOps in the future
$TemplatePath = Get-Location | Split-Path | Split-Path | Split-Path

#Deploy application insights
$TemplateFile = "$TemplatePath\storage.template.json"
$TemplateParametersFile = "storage.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile



# Enabling the static site hosting option.
$storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $storageAccountName
Enable-AzStorageStaticWebsite -Context $storageAccount.Context -IndexDocument index.html -ErrorDocument404Path index.html
