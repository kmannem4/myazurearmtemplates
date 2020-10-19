$Password1 = ConvertTo-SecureString -String "NovExpCerts!" -AsPlainText -Force
$VaultName1 = "amn-wus2-hub-kv-q01"
$cert1 = "wildcard-qa-ttm-amnhealthcare-com"
$file1 = "\\prod-vm-tools\Software\Devops\AMN CERTS\qa.ttm.amnhealthcare.com wildcard\qa-ttm-amnhealcare-com.pfx"
Import-AzKeyVaultCertificate -VaultName $VaultName1 -Name $cert1 -FilePath $file1 -Password $Password1