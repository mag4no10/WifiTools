#!/bin/sh
# Simple tshark WiFi EAP certificate extractor
# By dominic@sensepost.com
# All rights reserved 2018

if [ ! -x $(which tshark) ]; then
  echo "tshark not installed"
  exit 0
fi

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 [-r file.cap | -i interface]"
  echo "Extracted certificates will be written to <file|int>.cert.rand.der"
  exit 0
fi

tmpbase=$(basename  $2)
for x in $(tshark $1 $2 \
           -Y "ssl.handshake.certificate and eapol" \
           -T fields -e "ssl.handshake.certificate"); do 
  echo $x | \
  sed "s/://g" | \
  xxd -ps -r | \
  tee $(mktemp $tmpbase.cert.XXXX.der) | \
  openssl x509 -inform der -text; 
done