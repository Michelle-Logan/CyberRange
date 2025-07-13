<#
.SYNOPSIS
    This PowerShell script configures Windows to store only secure password hashes and enforce NTLMv2-only authentication.

.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-07-13
    Last Modified   : 2025-07-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000205).ps1 
#>

$lsaPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"

# Disable LM hash storage
Set-ItemProperty -Path $lsaPath -Name "NoLMHash" -Type DWord -Value 1

# Require NTLMv2 only and refuse LM & NTLM
Set-ItemProperty -Path $lsaPath -Name "LmCompatibilityLevel" -Type DWord -Value 5
