---
title: Openssl cheatsheet
author: Brett Wright
type: post
date: 2017-08-24

categories:
  - Openssl
  - Certificate

---

Export the private key file from the pfx file
```
openssl pkcs12 -in filename.pfx -nocerts -out key.pem
```

Export the certificate file from the pfx file
```
openssl pkcs12 -in filename.pfx -clcerts -nokeys -out cert.pem
```

Remove the passphrase from the private key
```
openssl rsa -in key.pem -out server.key
```

Show public certificates
```
openssl s_client -showcerts -connect google.com.au:443
```

Testing for tls encryption protocol
```
openssl s_client -connect google.com.au:443 -tls1_2
```