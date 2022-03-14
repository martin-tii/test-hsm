#!/bin/bash

#add line at the beginning of the file
sed -i '1s/^/openssl_conf = openssl_init\n/' /etc/ssl/openssl.cnf

# getting the system aarch64 or x86_64
system=$(uname -m)

#rpbi
if [[ "$system" == "aarch64" ]]; then
printf "\n[openssl_init]\nengines = engine_section\n\n[engine_section]\npkcs11 = pkcs11_section\n\n[pkcs11_section]\nengine_id = pkcs11\ndynamic_path = /usr/lib/engines-1.1/pkcs11.so\nMODULE_PATH = /usr/lib/softhsm/libsofthsm2.so" >> /etc/ssl/openssl.cnf
fi

#intel
if [[ "$system" == "x86_64" ]]; then
printf "\n[openssl_init]\nengines = engine_section\n\n[engine_section]\npkcs11 = pkcs11_section\n\n[pkcs11_section]\nengine_id = pkcs11\ndynamic_path = /usr/lib/x86_64-linux-gnu/engines-1.1/pkcs11.so #libP11/libpkcs11.so\nMODULE_PATH = /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so" >> /etc/ssl/openssl.cnf
fi

#loading softhsm library
LIB='/usr/lib/softhsm/libsofthsm2.so'

#intialize token
softhsm2-util --init-token --slot 0 --label MyTestToken1 --pin 1234 --so-pin 1234 ## this should be done before?

#create pair of keys
pkcs11-tool --module $LIB -l --keypairgen --key-type rsa:1024 --id 01 --label "MyRSATestKey01"

#obtain the pubkey certificate
openssl req -new -x509 -days 365 -subj '/CN=my key/' -sha256  -engine pkcs11 -keyform engine -key 01  -out /etc/ssl/certs/mesh_cert.pem

#!/bin/bash

#add line at the beginning of the file
sed -i '1s/^/openssl_conf = openssl_init\n/' /etc/ssl/openssl.cnf

# getting the system aarch64 or x86_64
system=$(uname -m)

#rpbi
if [[ "$system" == "aarch64" ]]; then
printf "\n[openssl_init]\nengines = engine_section\n\n[engine_section]\npkcs11 = pkcs11_section\n\n[pkcs11_section]\nengine_id = pkcs11\ndynamic_path = /usr/lib/engines-1.1/pkcs11.so\nMODULE_PATH = /usr/lib/softhsm/libsofthsm2.so" >> /etc/ssl/openssl.cnf
fi

#intel
if [[ "$system" == "x86_64" ]]; then
printf "\n[openssl_init]\nengines = engine_section\n\n[engine_section]\npkcs11 = pkcs11_section\n\n[pkcs11_section]\nengine_id = pkcs11\ndynamic_path = /usr/lib/x86_64-linux-gnu/engines-1.1/pkcs11.so #libP11/libpkcs11.so\nMODULE_PATH = /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so" >> /etc/ssl/openssl.cnf
fi

#loading softhsm libraryhis
LIB='/usr/lib/softhsm/libsofthsm2.so'

#intialize token
softhsm2-util --init-token --slot 0 --label MyTestToken1 --pin 1234 --so-pin 1234 ## this should be done before?

echo 'hello hello' > data


METHOD="RSA-PKCS"


#generate keys
pkcs11-tool --keypairgen --key-type="RSA:1024"  --login --pin=1234 --module=$LIB --label="myKey" --id=01
#export to der
pkcs11-tool --read-object --id 01 --type pubkey --output-file 01.der --module=$LIB
#export to pub
openssl rsa -inform DER -outform PEM -in 01.der -pubin > 01.pub
#encrypt
openssl rsautl -encrypt -inkey 01.pub -in data -pubin -out data.crypt
#decrypt
pkcs11-tool --id 01 --decrypt -p 1234 -m $METHOD --module $LIB --input-file data.crypt > data.decrypted