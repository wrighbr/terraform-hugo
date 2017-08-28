---
title: Export Private key and Public Certificate
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
