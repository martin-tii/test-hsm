#!/bin/bash
openssl x509 -in $1 -pubkey -noout > public_key.pem #to get public key from crt
openssl x509 -in $1 -out cert.der -outform DER # to convert to der format
