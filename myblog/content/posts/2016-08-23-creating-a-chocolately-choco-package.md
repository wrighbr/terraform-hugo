---
title: Creating a Chocolately / Choco package
author: Brett
type: post
date: 2016-08-23T05:15:23+00:00
url: /index.php/2016/08/23/creating-a-chocolately-choco-package/
categories:
  - PowerShell
tags:
  - Choco
  - Chocolately
  - DevOps
  - PowerShell

---
Open PowerShell or Command Prompt as an Administrator
  
Create a directory called Choco-Repo and change into that directory
```
mkdir c:\Choco-Repo
cd C:\Choco-Repo
```

Create a new package
```
choco new 'My-App'
```

Open c:\choco-repo\My-App\My-App.nuspec with your favourite text editor (notepad++) and modify the file to look the below.

```

<!-- Do not remove this test for UTF-8: if “Ω” doesn’t appear as greek uppercase omega letter enclosed in quotation marks, you should use an editor that supports UTF-8, not this one. -->
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
  <metadata>
    

<!-- Read this before publishing packages to chocolatey.org: https://github.com/chocolatey/chocolatey/wiki/CreatePackages -->
    <id>My-App</id>
    

<title>
  My-App (Install)
</title>
    <version>7.1.1</version>
    <authors>My Software Company</authors>
    <owners>My Software Company</owners>
    <summary>My Application</summary>
    <description>
      This is my App. There are many like it, but this one is mine. My App is my best friend. It is my life. I must master it as I must master my life. My App, without me, is useless. Without my App, I am useless.
    </description>
    <projectUrl>http://www.myapp.com</projectUrl>
    <tags>my-app admin</tags>
    <copyright></copyright>
    <licenseUrl>http://www.myapp.com</licenseUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    

<!--<dependencies>
      <dependency id="" version="__VERSION__" />
      <dependency id="" />
    </dependencies>-->
    <releaseNotes></releaseNotes>
  </metadata>
  <files>
    <file src="tools\**" target="tools" />
  </files>
</package>
```
Open c:\choco-repo\My-App\tools\chocolateyinstall.ps1
  
Edit PowerShell script to look something like the below.
```
$ErrorActionPreference = 'Stop';

$packageName = 'My-App'
$installerType = 'MSI'
$url = 'http://files.myapp.com/myapp.msi'
$silentArgs = '/qn'
$validExitCodes = @(0, 3010) 

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
```
Change into the My-App directory and create the nuget/chocolate package
```
choco pack .\My-App.nuspec
```
Testing that your nuget / choco works
```
choco install My-App -source .\My-App.nupkg
```