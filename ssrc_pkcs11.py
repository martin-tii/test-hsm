import pkcs11
from pkcs11 import Attribute, ObjectClass
from pkcs11.util.x509 import decode_x509_certificate


def parse_der(der):
    with open(der, "rb") as f:
        return decode_x509_certificate(f.read())


def get_public_key(der):
    with open(der, "rb") as f:
        aux = pkcs11.util.x509.decode_x509_public_key(f.read())
        return aux