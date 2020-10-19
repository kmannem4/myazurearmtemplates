# To run: open PowerShell, cd to the directory where this script is located, type .\deploy.api.ps1 and hit enter
# If using VS Code: right-click on the folder where this script is located, select Open in Terminal, in the terminal type .\deploy.ps1 and hit enter

#Enable this step if you are deploying using Release pipeline
#Disable this step if you are deploying locally
cd 'BuildOutput\Artifacts\src\ARM\Infrastructure\Environments\TTMInsights\DEV'

#Disable this step if you are deploying using Release pipeline
#Enable this step if you are deploying locally
#Connect-AzAccount

#Please Verify the Subscription correctly before commiting changes
Set-AzContext -Subscription 'AMN Shiftwise Dev'

#Please Verify the Resource Group name correctly before commiting changes
$ResourceGroupName = 'amn-wus2-ttm-rg-d01'

#our default location in azure is westus2, unless you are deploying a Disaster recovery or standy environment wich should use west central us
$ResourceGroupLocation = 'WestUS2'

# Create or update the resource group using the specified template file and template parameters file
New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

#Location on personal drive. Should update to reference URI in DevOps in the future
$TemplatePath = Get-Location | Split-Path | Split-Path | Split-Path

#Deploy application insights
$TemplateFile = "$TemplatePath\appinsights.template.json"
$TemplateParametersFile = "appinsights.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile


# Deploy network 
# Uncomment below when deploying to brand new environment. 
# Comment out/do not run after VNet Peerings have been set up.
#$TemplateFile = "$TemplatePath\network.template.json"
#$TemplateParametersFile = "network.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile


#Deploy app service managed identity
$TemplateFile = "$TemplatePath\asmanagedID.template.json"
$TemplateParametersFile = "asmanagedID.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy initial app service plan
$TemplateFile = "$TemplatePath\appserviceplan.template.json"
$TemplateParametersFile = "appserviceplan.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy initial app service
$TemplateFile = "$TemplatePath\appservice.template.json"
$TemplateParametersFile = "appservice.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Configuring  app service
$TemplateFile = "$TemplatePath\appservice-2.template.json"
$TemplateParametersFile = "appservice-2.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy app service plan autoscale
$TemplateFile = "$TemplatePath\appserviceplanautoscale.template.json"
$TemplateParametersFile = "appserviceplanautoscale.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy Functions App service Plan
$TemplateFile = "$TemplatePath\func_appserviceplan.template.json"
$TemplateParametersFile = "func_appserviceplan.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy Functions App
$TemplateFile = "$TemplatePath\functions_app.template.json"
$TemplateParametersFile = "functions_app.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

# Deploy post NSG (all the routing rules for NSG can be specified at this point)
$TemplateFile = "$TemplatePath\post_nsg.template.json"
$TemplateParametersFile = "post_nsg.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile


#Deploy Private DNS
$TemplateFile = "$TemplatePath\private_dns.template.json"
$TemplateParametersFile = "private_dns.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy CosmosDB
$TemplateFile = "$TemplatePath\cosmosDB.template.json"
$TemplateParametersFile = "cosmosDB.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

#Deploy Private link (this will create a private endpoint for cosmosDB and also adds DNS entries under Private DNS)
$TemplateFile = "$TemplatePath\private_link.template.json"
$TemplateParametersFile = "private_link.parameters.json"
$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
New-AzResourceGroupDeployment -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParametersFile

