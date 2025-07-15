# Windows STIG Hardening Script - WN10-SO-000025

## Overview
This repository contains a PowerShell script designed to automate the remediation of security findings based on the Defense Information Systems Agency (DISA) Security Technical Implementation Guides (STIGs) for Windows systems.

The goal of this script is to provide a reliable and efficient way to apply security configurations, ensuring compliance and hardening systems against vulnerabilities.

---

## Script
This repository contains the script for the following STIG:

| STIG ID | Description | Script File |
| :--- | :--- | :--- |
| **WN10-SO-000025** | The built-in administrator account must be renamed. | [`Set-StigCompliance.WN10-SO-000025.ps1`](https://github.com/jorjuarez/DISA-STIG-Hardening-with-PowerShell-WN10-SO-000025/blob/main/STIG-ID-WN10-SO-000025.ps1) |

---

## Usage
The script is designed to be run individually with administrative privileges in a PowerShell console. It requires a new name to be provided as a parameter.

**Example:**

To apply the remediation for STIG `WN10-SO-000025`:

```powershell
# First, open PowerShell as an Administrator.

# Navigate to the folder where you saved the script.
cd C:\Path\To\Your\Scripts

# If you downloaded the script from the internet, unblock it first.
Unblock-File -Path '.\Set-StigCompliance.WN10-SO-000025.ps1'

# Execute the script, providing a new name for the administrator account.
.\'Set-StigCompliance.WN10-SO-000025.ps1' -NewName "YourNewAdminName"
```
### ⚠‼ Important Prerequisite for Account Management Scripts
Before running scripts that modify the built-in administrator account (such as **WN10-SO-000005** - Disable Account and **WN10-SO-000025** - Rename Account), you **must** ensure you have a separate, active administrator account.

**Outcome if Not Followed:** If the built-in administrator is the only account you use for remote access (RDP/Bastion), running these scripts **will lock you out** of the machine.

**Workaround for Azure VMs:** If you get locked out of an Azure VM, you can regain access by using the **"Reset password"** feature in the Azure portal to create a new, temporary administrator account.

---
## Disclaimer
This script is provided as-is. Always test it in a non-production environment before deploying to live systems. The user assumes all risk associated with running this script.

---
## Connect With Me
* **LinkedIn:** linkedin.com/in/jorgejuarez1
* **GitHub:** github.com/jorjuarez
