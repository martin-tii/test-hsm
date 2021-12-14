# Test python pksc11.py

create the certificate:

`python3 creation.py`

will generate two files called:
1. the private key ('private.key') 
2. the certificate in pem format ('test.crt')

Then, as the python-pks11 tool needs certificates in _der_ format, we can run:

`./convert test.crt`

the execution will provide two new files
1. the public key generated ('public_key.pem')
2. the certificate in _der_ format ('cert.der')

Now, with all the previous steps, we will run the python-pkcs11 tool.

`python3 test-pkcs11.py'
