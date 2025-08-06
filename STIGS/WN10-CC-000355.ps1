<#
.SYNOPSIS
    This PowerShell script ensures the WinRM service won’t cache or store credentials used via RunAs, helping prevent credential theft or reuse if the system is compromised.
    
.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-08-06
    Last Modified   : 2025-08-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000355

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000355).ps1 
#>

New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\WinRM\Service" -Force
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WinRM\Service" -Name "DisableRunAs" -Value 1 -Type DWord
