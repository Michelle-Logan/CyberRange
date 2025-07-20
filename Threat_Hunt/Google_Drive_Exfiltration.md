# Threat Event (Sensitive File Upload to Personal Google Drive)
**User Uploads Confidential Files to External Cloud Storage Platform**

## Steps the "Bad Actor" took Create Logs and IoCs:
1. User accessed a restricted share containing sensitive documents.

2. Files were copied locally to the user's desktop.

3. User opened a browser and navigated to `https://drive.google.com`.

4. Files were uploaded to a personal Google account using the web interface.

---

## Tables Used to Detect IoCs:
| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceFileEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-devicefileevents-table|
| **Purpose**| Detects file access and local copy events from protected folders.|

| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceProcessEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-deviceprocessevents-table|
| **Purpose**| Tracks use of web browsers and file open/save activity.|

| **Parameter**       | **Description**                                                              |
|---------------------|------------------------------------------------------------------------------|
| **Name**| DeviceNetworkEvents|
| **Info**|https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-devicenetworkevents-table|
| **Purpose**| Contains information about events involving the processing of emails on Microsoft Defender for Office 365. |

---

## Related Queries:
```kql
// Detect file access from protected directories
DeviceFileEvents
| where FolderPath has_any("C:\\Finance\\", "C:\\HR\\", "C:\\Sensitive\\")
| where ActionType in ("FileRead", "FileCopied")
| project Timestamp, DeviceName, FileName, FolderPath, RequestAccountName

// Detect large or repeated uploads to Google Drive
DeviceNetworkEvents
| where RemoteUrl has "drive.google.com"
| where Protocol == "HTTPS"
| where InitiatingProcessFileName in~ ("chrome.exe", "msedge.exe", "firefox.exe")
| project Timestamp, DeviceName, AccountName, RemoteUrl, InitiatingProcessFileName, ReportId

// Detect browser activity during suspected upload window
DeviceProcessEvents
| where FileName in~ ("chrome.exe", "msedge.exe", "firefox.exe")
| project Timestamp, DeviceName, AccountName, FileName, ProcessCommandLine

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
