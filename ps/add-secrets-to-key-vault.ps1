param(
    [string]$keyVaultName,
    [securestring]$sqlAdminLogin,
    [securestring]$sqlAdminLoginPassword
)

$keyName = "pat-sql-db-lab--sql-admin-login"
.\ps\add-secret-to-key-vault.ps1 -vaultName $keyVaultName -name $keyName -secretValue $sqlAdminLogin

$keyName = "pat-sql-db-lab--sql-admin-login-password"
.\ps\add-secret-to-key-vault.ps1 -vaultName $keyVaultName -name $keyName -secretValue $sqlAdminLoginPassword
