<#
.SYNOPSIS
    This PowerShell script ensures that Windows will generate audit events for other logon or logoff events.

.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-07-09
    Last Modified   : 2025-07-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000565

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000565.ps1 
#>

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator."
    exit
}

# Enable "Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings"
secedit /export /cfg C:\auditcfg.inf
(Get-Content -Path C:\auditcfg.inf).Replace("MACHINE\System\CurrentControlSet\Control\Lsa","MACHINE\System\CurrentControlSet\Control\Lsa`r`nAuditBaseObjects = 1") | Set-Content -Path C:\auditcfg.inf
secedit /configure /db secedit.sdb /cfg C:\auditcfg.inf /areas SECURITYPOLICY
Remove-Item C:\auditcfg.inf

# Set "Other Logon/Logoff Events - Failure" to audit
auditpol /set /subcategory:"Other Logon/Logoff Events" /failure:enable

Write-Output "Remediation complete. It's recommended to verify with: auditpol /get /category:*"
