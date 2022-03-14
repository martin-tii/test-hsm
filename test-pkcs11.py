#! /usr/bin/python3

from __future__ import print_function

from PyKCS11 import *
import binascii
import sys

pkcs11 = PyKCS11Lib()
pkcs11.load()  # define environment variable PYKCS11LIB=YourPKCS11Lib

# get 1st slot
slot = pkcs11.getSlotList(tokenPresent=True)[0]

session = pkcs11.openSession(slot, CKF_SERIAL_SESSION | CKF_RW_SESSION)
session.login("1234")
pubKey = session.findObjects([(CKA_CLASS, CKO_PUBLIC_KEY)])[0]
privKey = session.findObjects([(CKA_CLASS, CKO_PRIVATE_KEY)])[0]
print('Enter text to cipher:')
inp = input()
message = inp.encode('utf-8').hex()


enc = session.encrypt(pubKey, binascii.unhexlify(message))
dec = session.decrypt(privKey, enc)
print("\nmessage in hex: " + message)
print("\nencrypted: {}".format(binascii.hexlify(bytearray(enc))))
print("\ndecrypted: {}".format(bytearray(dec)))

# logout
session.logout()
session.closeSession()
