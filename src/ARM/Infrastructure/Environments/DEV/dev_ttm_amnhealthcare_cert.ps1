$Password1 = ConvertTo-SecureString -String "AMNHealthcare" -AsPlainText -Force
$VaultName1 = "amn-wus2-hub-kv-d01"
$cert1 = "wildcard-dev-ttm-amnhealthcare-com"
$file1 = "\\prod-vm-tools\Software\Devops\AMN CERTS\dev.ttm.amnhealthcare.com wildcard\dev-ttm-amnhealcare-com.pfx"
Import-AzKeyVaultCertificate -VaultName $VaultName1 -Name $cert1 -FilePath $file1 -Password $Password1