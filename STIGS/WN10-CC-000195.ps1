<#
.SYNOPSIS
    This PowerShell script creates or modifies the EnhancedAntiSpoofing registry value under HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures and sets it to 1 to enable enhanced spoofing protection for Windows Hello facial recognition.

.NOTES
    Author          : Michelle Logan
    LinkedIn        : linkedin.com/in/michellelogan2/
    GitHub          : github.com/Michelle-Logan
    Date Created    : 2025-08-05
    Last Modified   : 2025-08-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000195

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000195).ps1 
#>

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" -Name "EnhancedAntiSpoofing" -Value 1 -Type DWord
