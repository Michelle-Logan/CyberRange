<#
.SYNOPSIS
    This PowerShell script disables PKU2U online ID authentication by setting AllowOnlineID = 0.

.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-07-13
    Last Modified   : 2025-07-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000185).ps1 
#>

New-Item -Path "HKLM:\System\CurrentControlSet\Control\Lsa\pku2u" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa\pku2u" -Name "AllowOnlineID" -Type DWord -Value 0
