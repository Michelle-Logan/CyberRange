<#
.SYNOPSIS
    This PowerShell script modifies local security policy to explicitly deny network logon access to the Guests group.

.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-07-13
    Last Modified   : 2025-07-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UR-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-UR-000070).ps1 
#>

# Ensure 'Guests' group is denied network access
secedit /export /cfg C:\secpol.cfg

# Read current value
$current = (Get-Content C:\secpol.cfg) -match 'SeDenyNetworkLogonRight'

# Append or update the value to include Guests SID
if ($current.Count -eq 0) {
    Add-Content -Path C:\secpol.cfg -Value "SeDenyNetworkLogonRight = *S-1-5-32-546"
} elseif ($current[0] -notmatch "S-1-5-32-546") {
    (Get-Content C:\secpol.cfg) | ForEach-Object {
        $_ -replace '^(SeDenyNetworkLogonRight\s*=\s*)(.*)', '$1*\2,*S-1-5-32-546'
    } | Set-Content C:\secpol.cfg
}

# Import updated policy
secedit /configure /db secedit.sdb /cfg C:\secpol.cfg /quiet

# Cleanup
Remove-Item C:\secpol.cfg -Force
