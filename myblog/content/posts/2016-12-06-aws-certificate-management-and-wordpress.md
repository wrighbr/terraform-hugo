---
title: AWS Certificate Management and WordPress
author: Brett
# type: post
# date: 2016-12-06T04:25:37+00:00
# url: /aws-certificate-management-and-wordpress/
categories:
  - AWS
  - Certificates
  - ec2
  - elb

---
**Create AWS Certificate**

  1. Open AWS Console.
  2. Services > Security > Certificate Manager.
  <img src="/images/CertManager.jpg"> 
  3.  Select Request Certificate
  4. Type domain name and click Review & Request
  5. Review the domain and Confirm and Request.
  6. An email will be sent to the webmaster/hostmaster/admin
  7. Once you have received to the email click on the link within the email to approve the request.

**Binding the Certificate to an EC2 Instance / Elastic Load Balancer (ELB)**

  1. Open AWS Console
  2. Services > Compute > EC2
  3. On the side menu select Load Balancesrs under LOAD BALANCING
  4. Select Create Load Balancer
  5. Select Classic load balance > Click Continue.
  6. Type WordPress as the name of the Load Balance
  7. Click Add and choose HTTPS (Secure HTTP) as the protocol (Leave Instance port as 80). Click Next: Assign Scurity Groups
  8. Select Create a new security group. Name security group and allow port 80 and 443 from Anywhere 0.0.0.0/0. Click Next.
  9. Choose an **existing** certificate from AWS Certificate Manager (ACM).
 10. From the drop menu select the certificate you created early. Click Next.
 11. Select from the drop down menu TCP. Click Next.
 12. Select the EC2 Instances that you want to be in the ELB. Click Next.
 13. Click Review and Create.
 14. Click Create.

**Enabling HTTPS within WordPress**

  1. Log into WordPress
  2. Navigate to Plugins > Add New
  3. Search for WordPress HTTPS
  4. Install and active plugin

**Testing SSL Certificate**

Head to <https://www.ssllabs.com/ssltest> and enter the domain name and test the SSL Certificate.

<img src="/images/CertScore.jpg"> 
