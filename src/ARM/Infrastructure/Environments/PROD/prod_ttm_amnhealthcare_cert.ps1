$Password1 = ConvertTo-SecureString -String "TTMwildcard" -AsPlainText -Force
$VaultName1 = "amn-wus2-hub-kv-p01"
$cert1 = "wildcard-ttm-amnhealthcare-com"
$file1 = "\\prod-vm-tools\Software\Devops\AMN CERTS\ttm.amnhealthcare.com wildcard\ttm-amnhealcare-com.pfx"
Import-AzKeyVaultCertificate -VaultName $VaultName1 -Name $cert1 -FilePath $file1 -Password $Password1