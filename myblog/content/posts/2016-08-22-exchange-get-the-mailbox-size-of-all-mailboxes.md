---
title: Exchange get the mailbox size of all mailboxes.
author: Brett
type: post
date: 2016-08-22T04:47:01+00:00
url: /index.php/2016/08/22/exchange-get-the-mailbox-size-of-all-mailboxes/
categories:
  - Exchange
  - PowerShell

---
To obtain the mailbox size of all mailboxes ran the below command within Exchange Management Shell

<pre lang="powershell">Get-Mailbox -Database Database | Get-MailboxStatistics | Format-Table DisplayName, TotalItemSize
</pre>