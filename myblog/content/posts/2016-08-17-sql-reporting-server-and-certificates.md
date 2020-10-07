---
title: SQL Reporting Services and Certificates
author: Brett
# type: post
# date: 2016-08-17T07:28:45+00:00
# url: /sql-reporting-server-and-certificates/
categories:
  - SQL
  - certificate
  - reporting service

---
**Error Message**
  
Create certificate binding. We were unable to create the certificate binding. 
Reserving url https://reports.domain.local:443 The Url has already been reserved

**Resolution**
  
Open Reporting Services Cofiguration Manager
  
Remove certificate from the SQL Report Services
  
open command prompt as an administrator and type the below command
```  
netsh http show sslcert
```
This will show that there is a cert is still bound to port 443.

Ran the below command and this will remove the binding
```
netsh http delete sslcert ipport=1.1.1.1:443
```
After this you will be able bind the cert to the reporting services