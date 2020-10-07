---
title: 'Certbot & Let’s Encrypt (Free SSL Certs)'
author: Brett
# type: post
# date: 2016-12-06T04:47:31+00:00
# url: /certbot-lets-encrypt-free-ssl-certs/
categories:
  - Certificates
  - Linux

---
Well obtain a free SSL cert couldn't be easier with Certbot & Let's Encrypt

Download Certbot 
```
wget https://dl.eff.org/certbot-auto chmod a+x certbot-auto 
```

Install your free certificate with certbot
```
./certbot-auto
```

Creating cron job to auto renew cert very 12 hours.
```
crontab -e \* \*/12 \* \* * /path-to/certbot-auto renew --quiet --no-self-upgrade
```

https://certbot.eff.org/