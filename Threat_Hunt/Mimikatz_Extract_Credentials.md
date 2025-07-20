# Threat Event (Credential Dumping via Mimikatz)
**Use of Mimikatz to Extract Credentials from LSASS Memory**

## Steps the "Bad Actor" took Create Logs and IoCs:
1. Downloaded the Mimikatz binary (e.g., `mimikatz.exe`) and saved it to a temporary folder.

2. Executed `mimikatz.exe` with administrative privileges.

3. Elevated to debug privileges using:

   ```txt

   privilege::debug

   ```

4. Dumped plaintext credentials using:

   ```txt

   sekurlsa::logonpasswords

   ```

 5.  Deleted the executable to reduce artifacts.

---

## Tables Used to Detect IoCs:
| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceFileEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-devicefileevents-table|
| **Purpose**| Detects the creation, movement, or deletion of mimikatz.exe.|

| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceImageLoadEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-deviceimageloadevents-table|
| **Purpose**| Can detect LSASS memory access or suspicious DLLs loaded by non-system processes.|



---

## Related Queries:
```kql
// Detect execution of mimikatz.exe
DeviceProcessEvents
| where FileName in~ ("mimikatz.exe", "mimidrv.sys")
| project Timestamp, DeviceName, AccountName, ProcessCommandLine

// Detect common mimikatz commands used via PowerShell or cmd
DeviceProcessEvents
| where ProcessCommandLine has_any ("sekurlsa::logonpasswords", "privilege::debug")
| project Timestamp, DeviceName, AccountName, ProcessCommandLine

// Detect download or creation of mimikatz in suspicious folders
DeviceFileEvents
| where FileName has "mimikatz"
| where FolderPath has_any ("C:\\Users\\Public", "C:\\Temp", "C:\\Downloads")
| project Timestamp, DeviceName, RequestAccountName, FileName, FolderPath, ActionType


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
