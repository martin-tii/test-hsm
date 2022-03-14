# Test python pksc11.py


Initialize the softhsm token and generate keys:

`./create-keys.sh`

```commandline
root@br_hardened:~/test# ./generate-keys.sh 
The token has been initialized and is reassigned to slot 1158325
Using slot 0 with a present token (0x11acb5)
Logging in to "MyTestToken1".
Please enter User PIN: 
Key pair generated:
Private Key Object; RSA 
  label:      MyRSATestKey01
  ID:         01
  Usage:      decrypt, sign, unwrap
  Access:     sensitive, always sensitive, never extractable, local
Public Key Object; RSA 1024 bits
  label:      MyRSATestKey01
  ID:         01
  Usage:      encrypt, verify, wrap
  Access:     local
engine "pkcs11" set.
Enter PKCS#11 token PIN for MyTestToken1:
CKR_SLOT_ID_INVALID: Slot 0 does not exist.
Using slot 0 with a present token (0x11acb5)
Key pair generated:
Private Key Object; RSA 
  label:      myKey
  ID:         01
  Usage:      decrypt, sign, unwrap
  Access:     sensitive, always sensitive, never extractable, local
Public Key Object; RSA 1024 bits
  label:      myKey
  ID:         01
  Usage:      encrypt, verify, wrap
  Access:     local
Using slot 0 with a present token (0x11acb5)
writing RSA key
Using slot 0 with a present token (0x11acb5)
Using decrypt algorithm RSA-PKCS
```

Add the path to the environment:

`export PYKCS11LIB=/usr/lib/softhsm/libsofthsm2.so`

Finally, we run our script:

`python3 test-pkcs11.py`

```commandline

root@br_hardened:~# python3 test-pkcs11.py 
Enter text to cipher:
Hello

message in hex: 48656c6c6f

encrypted: b'4bb67bbf084b999870195fe0f6e4e36ab0c54e31f36ceb9c8ff590a32493eaa8e8e4b27c81d25574de2097774f632c7fbc4a52a0e43e47b88460d9bd7941691fdf80c451f7cae85e0d2ab77533202a9df1fe14f3087e72040d7fc84912891ffd17ebc0c5282f60fec895330e868bdb518588992ef07ab6e49a4671691f77ce7f'

decrypted: bytearray(b'Hello')



```

