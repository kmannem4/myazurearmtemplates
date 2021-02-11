# To run: open PowerShell, cd to the directory where this script is located, type .\deploy.api.ps1 and hit enter
# If using VS Code: right-click on the folder where this script is located, select Open in Terminal, in the terminal type .\deploy.ps1 and hit enter

#Enable this step if you are deploying using Release pipeline
#Disable this step if you are deploying locally
cd 'BuildOutput\Artifacts\src\ARM\Infrastructure\Environments\DEV'

#Disable this step if you are deploying using Release pipeline
#Enable this step if you are deploying locally
#Connect-AzAccount

#Please Verify the Subscription correctly before commiting changes
Set-AzContext -Subscription 'AMN Intelligent Platform Services Dev'

#Please Verify the Resource Group name correctly before commiting changes
$ResourceGroupName = 'amn-wus2-hub-rg-d01'

#our default location in azure is westus2, unless you are deploying a Disaster recovery or standy environment wich should use west central us
$ResourceGroupLocation = 'WestUS2'

# Create or update the resource group using the specified template file and template parameters file
New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

#Location on personal drive. Should update to reference URI in DevOps in the future
$TemplatePath = Get-Location | Split-Path | Split-Path

# Deploy application insights 
#$TemplateFile = "$TemplatePath\appinsights.template.json"
#$TemplateParametersFile = "appinsights.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile


# Deploy network security group and VNET
# Uncomment below when deploying to brand new environment. 
# Comment out/do not run after VNet Peerings have been set up.
#$TemplateFile = "$TemplatePath\network.template.json"
#$TemplateParametersFile = "network.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy public_IP 
#$TemplateFile = "$TemplatePath\public_ip.template.json"
#$TemplateParametersFile = "public_ip.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy App gateway managed Identity 
#$TemplateFile = "$TemplatePath\agwmanagedID.template.json"
#$TemplateParametersFile = "agwmanagedID.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy Key vault 
#$TemplateFile = "$TemplatePath\keyvault.template.json"
#$TemplateParametersFile = "keyvault.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

#After deploying keyvault import certificate to the key vault
#& $TemplatePath\Environments\DEV\dev_ttm_amnhealthcare_cert.ps1
#& $TemplatePath\Environments\DEV\shiftwise_wildcard_cert.ps1

# Deploy api management 
#$TemplateFile = "$TemplatePath\apim.template.json"
#$TemplateParametersFile = "apim.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy private_dns 
#$TemplateFile = "$TemplatePath\private_dns.template.json"
#$TemplateParametersFile = "private_dns.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy app gateway 
#$TemplateFile = "$TemplatePath\agw.template.json"
#$TemplateParametersFile = "agw.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy WAF
#$TemplateFile = "$TemplatePath\waf.template.json"
#$TemplateParametersFile = "waf.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile

# Deploy initial AFD
#$TemplateFile = "$TemplatePath\afd_initial.template.json"
#$TemplateParametersFile = "afd_initial.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile


# This task should be run only if initial azure front door was created and this is used to create DNS entries before adding custome domain in AFD
#& $TemplatePath\Environments\DEV\dns_zone_deploy.ps1

#Set-AzContext -Subscription 'AMN Intelligent Platform Services Dev'

# Deploy custom domain in afd 
#$TemplateFile = "$TemplatePath\afd.template.json"
#$TemplateParametersFile = "afd.parameters.json"
#$DeploymentName = ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm'))
#New-AzResourceGroupDeployment -Name $DeploymentName `
#    -ResourceGroupName $ResourceGroupName `
#    -TemplateFile $TemplateFile `
#    -TemplateParameterFile $TemplateParametersFile
