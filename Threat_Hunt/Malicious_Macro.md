# Threat Event (Malicious Office Macro)
**Suspicious Excel File Delivered via Phishing Email**

## Steps the "Bad Actor" took Create Logs and IoCs:
1. Create a Malicious Macro File (Safe Simulation)
Open Excel > New Workbook

Press ALT + F11 to open the VBA Editor

Insert a new module and paste:

vb
Copy
Edit
Sub AutoOpen()
    MsgBox "Payload executing..."
End Sub
Save the file as a Macro-Enabled Workbook:
malicious.xlsm

2. Simulate Payload Execution
Open the file.

Click Enable Content when prompted.

The macro runs and displays the message box.

In real attacks, the macro would download and execute a payload using powershell, certutil, or mshta.

---

## Tables Used to Detect IoCs:
| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceFileEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-deviceinfo-table|
| **Purpose**| Used to detect download or creation of suspicious .xlsm files. |

| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceProcessEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-deviceinfo-table|
| **Purpose**| Used to detect Office processes spawning PowerShell or command prompt.|

| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| EmailEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-emailevents-table|
| **Purpose**| Contains information about events involving the processing of emails on Microsoft Defender for Office 365. |

---

## Related Queries:
```kql
// Detect Office apps spawning PowerShell or cmd
DeviceProcessEvents
| where InitiatingProcessFileName has_any("excel.exe", "winword.exe")
| where FileName has_any("powershell.exe", "cmd.exe", "mshta.exe", "regsvr32.exe")
| project Timestamp, DeviceName, AccountName, InitiatingProcessFileName, ProcessCommandLine

// Detect macro-enabled Office file creation or download
DeviceFileEvents
| where FileName endswith ".xlsm" or FileName endswith ".docm"
| project Timestamp, DeviceName, FileName, FolderPath, ActionType

// Detect macro-laden files received via email
EmailEvents
| where AttachmentFileType in ("xlsm", "docm", "pptm")
| project Timestamp, RecipientEmailAddress, SenderFromAddress, Subject, NetworkMessageId

```
## Created By:
- **Author Name**: Michelle Logan
- **Author Contact**: https://www.linkedin.com/in/michellelogan2
- **Date**: July 20, 2025

## Validated By:
- **Reviewer Name**: 
- **Reviewer Contact**: 
- **Validation Date**: 

---

## Additional Notes:
- **None**

---

## Revision History:
| **Version** | **Changes**                   | **Date**         | **Modified By**   |
|-------------|-------------------------------|------------------|-------------------|
| 1.0         | Initial draft                  | `July 20, 2025`  | `Michelle Logan`   
