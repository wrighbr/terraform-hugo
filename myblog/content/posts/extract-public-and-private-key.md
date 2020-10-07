---
title: Openssl cheatsheet
author: Brett Wright
# type: post
# date: 2017-08-24

categories:
  - Openssl
  - Certificate

---

Export the private key file from the pfx file
```
openssl pkcs12 -in filename.pfx -nocerts -out key.pem -nodes
```
Remove a private key password
```
openssl rsa -in key.pem out key2.pem
```

Export the certificate file from the pfx file
```
openssl pkcs12 -in filename.pfx -nokeys -out cert.pem
```

Show public certificates
```
openssl s_client -showcerts -connect google.com.au:443
```

Testing for tls encryption protocol
```
openssl s_client -connect google.com.au:443 -tls1_2
```

Make a pfx file from a public and private keys
```
openssl pkcs12 -export -out domain.name.pfx -inkey key.pem -in cert.pem
```

Compare certificate and key to see if they match
```
openssl x509 -noout -modulus -in server.crt | openssl md5
openssl rsa -noout -modulus -in server.key | openssl md5
```
