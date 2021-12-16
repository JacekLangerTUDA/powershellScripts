
$script = .\gitPullAll.ps1;
$authenticode = New-SelfSignedCertificate -Subject "ATA Authenticode" -CertStoreLocation Cert:\LocalMachine\My -Type CodeSigningCert

# Add the self-signed Authenticode certificate to the computer's root certificate store.
## Create an object to represent the LocalMachine\Root certificate store.
"setRootStore"
 $rootStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("Root","LocalMachine")
## Open the root certificate store for reading and writing.
"openRootStore"
 $rootStore.Open("ReadWrite")
## Add the certificate stored in the $authenticode variable.
"add authenticode to RootStore"
 $rootStore.Add($authenticode)
## Close the root certificate store.
"close rootStore"
 $rootStore.Close()
 
# Add the self-signed Authenticode certificate to the computer's trusted publishers certificate store.
## Create an object to represent the LocalMachine\TrustedPublisher certificate store.
"set publisher store"
 $publisherStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("TrustedPublisher","LocalMachine")
## Open the TrustedPublisher certificate store for reading and writing.
"open publisher store"
 $publisherStore.Open("ReadWrite")
## Add the certificate stored in the $authenticode variable.
"add Authenticode to publisher store"
 $publisherStore.Add($authenticode)
## Close the TrustedPublisher certificate store.
"close publisher store"
 $publisherStore.Close()

 "verify..."
 # Confirm if the self-signed Authenticode certificate exists in the computer's Personal certificate store

 Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq "CN=ATA Authenticode"}
"Confirm if the self-signed Authenticode certificate exists in the computer's Root certificate store"
 Get-ChildItem Cert:\LocalMachine\Root | Where-Object {$_.Subject -eq "CN=ATA Authenticode"}
"Confirm if the self-signed Authenticode certificate exists in the computer's Trusted Publishers certificate store"
 Get-ChildItem Cert:\LocalMachine\TrustedPublisher | Where-Object {$_.Subject -eq "CN=ATA Authenticode"}
"Get the code-signing certificate from the local computer's certificate store with the name *ATA Authenticode*"
# Get the code-signing certificate from the local computer's certificate store with the name *ATA Authenticode* and store it to the $codeCertificate variable.
$codeCertificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq "CN=ATA Authenticode"}

"Signing the PowerShell script"
# Sign the PowerShell script
# PARAMETERS:
# FilePath - Specifies the file path of the PowerShell script to sign, eg. C:\ATA\myscript.ps1.
# Certificate - Specifies the certificate to use when signing the script.
# TimeStampServer - Specifies the trusted timestamp server that adds a timestamp to your script's digital signature. Adding a timestamp ensures that your code will not expire when the signing certificate expires.

Set-AuthenticodeSignature -FilePath C:\Users\langer\Desktop\Projects\Powershell\gitPullAll.ps1 -Certificate $codeCertificate[1] -TimeStampServer http://timestamp.comodoca.com/