# This task should be run only if initial azure front door was created and a dns entry was made which is related to the AFD that created in deploy.ps1
# To run: open PowerShell, cd to the directory where this script is located, type .\deploy.api.ps1 and hit enter
# If using VS Code: right-click on the folder where this script is located, select Open in Terminal, in the terminal type .\deploy.api.ps1 and hit enter

#Enable this step if you are deploying using Release pipeline
#Disable this step if you are deploying locally
cd 'BuildOutput\Artifacts\src\ARM\Infrastructure\Environments\QA'

#Disable this step if you are deploying using Release pipeline
#Enable this step if you are deploying locally
#Connect-AzAccount

#Please Verify the Subscription correctly before commiting changes
Set-AzContext -Subscription 'AMN Shiftwise Dev'

#Please Verify the Resource Group name correctly before commiting changes
$ResourceGroupName = 'AMN-WUS2-DNS-RG-DEV'

#our default location in azure is westus2, unless you are deploying a Disaster recovery or standy environment wich should use west central us
$ResourceGroupLocation = 'WestUS2'

# Create or update the resource group using the specified template file and template parameters file
New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

#Location on personal drive. Should update to reference URI in DevOps in the future
$TemplatePath = Get-Location | Split-Path | Split-Path

# Deploy DNS Zone 
$TemplateFile = "$TemplatePath\dns_zone.template.json"
$TemplateParametersFile = "dns_zone.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile
