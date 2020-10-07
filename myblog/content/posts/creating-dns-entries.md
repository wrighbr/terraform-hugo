---
title: Creating DNS Entries
author: Brett
type: post
# date: 2016-08-17T03:05:29+00:00
# url: /creating-dns-entries/

categories:
  - DNS
  - PowerShell
  - Windows

---
Create a single DNS entry
```
Add-DNSServerResourceRecordA -ZoneName 'domain.local' -Name test -IPv4Address 192.168.0.20
```
Create multiple DNS entries
```
Import-CSV c:\temp\newHosts.csv | %{
  Add-DNSServerResourceRecordA -ZoneName 'domain.local' -Name $_."HostName" -IPv4Address $_."IPAddress"
}
```