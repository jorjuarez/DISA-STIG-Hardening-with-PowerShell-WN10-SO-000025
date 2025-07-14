<#
.SYNOPSIS
    Renames the local, built-in administrator account to a new, compliant name.

.DESCRIPTION
    This script remediates the DISA STIG finding WN10-SO-000025 by renaming the built-in
    administrator account to a user-specified value. It identifies the account using its 
    well-known Security Identifier (SID) to ensure the correct account is targeted.
    
    Using a different name for the administrator account makes it more difficult for unauthorized 
    users to guess the credentials. This script requires you to provide the new name as a parameter.

.PARAMETER NewName
    The new name for the built-in administrator account. This name cannot be "Administrator"
    or blank.

.NOTES
    Author          : Jorge Juarez
    LinkedIn        : linkedin.com/in/jorgejuarez1
    GitHub          : github.com/jorjuarez
    Date Created    : 2025-07-14
    Last Modified   : 2025-07-14
    Version         : 1.0
    STIG-ID         : WN10-SO-000025
    Vulnerability-ID: V-220865

.LINK
    https://www.stigviewer.com/stig/windows_10/2021-08-18/finding/V-220865

.EXAMPLE
    PS C:\> .\'Set-StigCompliance.WN10-SO-000025.ps1' -NewName "LocalAdmin123"

    Executes the script from an elevated PowerShell prompt, renaming the built-in 
    administrator account to "LocalAdmin123".

.REQUIREMENTS
    - Requires administrative privileges to run.
#>

# --- Start of Script ---
param(
    [Parameter(Mandatory=$true)]
    [string]$NewName
)

# This command ensures that the script will stop if any command fails.
$ErrorActionPreference = "Stop"

# --- Main Logic ---
Write-Host "--- Applying STIG WN10-SO-000025 Remediation ---" -ForegroundColor Yellow

# Validate the new name parameter
if ($NewName -eq "Administrator" -or [string]::IsNullOrWhiteSpace($NewName)) {
    throw "The new name cannot be 'Administrator' or blank. Please provide a valid name."
}

try {
    # Find the built-in administrator account using its well-known SID (ends in -500)
    $AdminSID = "S-1-5-21-*-500"
    $AdminAccount = Get-LocalUser | Where-Object { $_.SID -like $AdminSID }

    if ($null -eq $AdminAccount) {
        throw "Could not find the built-in administrator account (SID ending in -500)."
    }

    Write-Host "Found built-in administrator account. Current name: $($AdminAccount.Name)"

    # Check if the account is already renamed to the desired name
    if ($AdminAccount.Name -eq $NewName) {
        Write-Host "Account is already named '$NewName'. No action needed." -ForegroundColor Green
    } else {
        # Rename the account
        Write-Host "Renaming account to '$NewName'..."
        Rename-LocalUser -Name $AdminAccount.Name -NewName $NewName
        Write-Host "Successfully renamed the administrator account." -ForegroundColor Green
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
}

# --- Verification ---
Write-Host "`n--- Verifying Changes ---" -ForegroundColor Yellow
try {
    # Re-fetch the account by SID to get the current state
    $AdminAccount = Get-LocalUser | Where-Object { $_.SID -like "S-1-5-21-*-500" }
    Write-Host "Current account name: $($AdminAccount.Name)"

    if ($AdminAccount.Name -eq $NewName) {
        Write-Host "SUCCESS: Remediation for WN10-SO-000025 verified. Account has been renamed." -ForegroundColor Green
    } else {
        Write-Warning "WARNING: Verification failed. The account name does not match the desired new name."
    }
}
catch {
    Write-Error "Failed to verify account name. An error occurred: $($_.Exception.Message)"
}

Write-Host "`n--- Script Complete ---"

# --- End of Script ---
