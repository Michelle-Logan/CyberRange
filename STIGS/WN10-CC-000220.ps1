<#
.SYNOPSIS
    This PowerShell script configures the current power plan so that when running on battery, the system requires a password when resuming from sleep.

.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-08-05
    Last Modified   : 2025-08-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000220

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000220).ps1 
#>

powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1
