param (
    [bool]$AlreadySignedIn = $false
)

################################################################################
### Login to Azure. 
################################################################################
if( $AlreadySignedIn -eq $false ) {
    # Do the login prompt
    Login-AzureRmAccount

    # Prompt for subscription selection
    $subscriptionId = 
        ( Get-AzureRmSubscription |
            Out-GridView `
            -Title "Select an Azure Subscription …" `
            -PassThru
        ).Id

    Get-AzureRmSubscription -SubscriptionId $subscriptionId | Select-AzureRmSubscription
}

################################################################################
### Populate credentials
################################################################################

$keyVaultName = Read-Host -Prompt 'Enter the name of the key vault to store credentials in'
if(!$keyVaultName) {
    Write-Error 'No Key Vault name entered. Terminating'
    exit 1
}

$sqlAdminLogin = Read-Host -Prompt 'Enter the login for the SQL administrator' -AsSecureString
if(!$sqlAdminLogin) {
    Write-Error 'No login entered. Terminating'
    exit 1
}

$sqlAdminLoginPassword = Read-Host -Prompt 'Enter the password for the SQL administrator' -AsSecureString
if(!$sqlAdminLoginPassword) {
    Write-Error 'No password entered. Terminating'
    exit 1
}

.\ps\add-secrets-to-key-vault.ps1 -keyVaultName $keyVaultName -sqlAdminLogin $sqlAdminLogin -sqlAdminLoginPassword $sqlAdminLoginPassword
