import pkcs11
import os
import ssrc_pkcs11 as sr

# Initialise our PKCS#11 library
lib = pkcs11.lib(os.environ['PKCS11_MODULE'])
token = lib.get_token(token_label='My token 1')
arr = input("Enter text to encrypt: ")
data = bytes(arr, 'utf-8')

with token.open(user_pin='12345') as session:
    public = session.create_object(sr.get_public_key('cert.der'))
    enc = public.encrypt(data)

print(enc)
