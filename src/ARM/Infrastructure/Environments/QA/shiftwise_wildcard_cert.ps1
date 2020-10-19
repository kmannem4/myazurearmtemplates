$Password1 = ConvertTo-SecureString -String "PV7sL7K556ytlCU#" -AsPlainText -Force
$VaultName1 = "amn-wus2-hub-kv-q01"
$cert1 = "shiftwise-wildcard"
$file1 = "\\prod-vm-tools\Software\Devops\AMN CERTS\shiftwise-wildcard\shiftwisewildcard.pfx"
Import-AzKeyVaultCertificate -VaultName $VaultName1 -Name $cert1 -FilePath $file1 -Password $Password1