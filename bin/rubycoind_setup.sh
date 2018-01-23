#!/bin/sh

# This script sets up the base rubycoind.conf file to be used by the rubycoind process. It only has
# an effect if there is no rubycoind.conf file in rubycoind's work directory.
#
# The options it sets can be tweaked by setting environmental variables when creating the docker
# container.
#

set -e

if [ -e "/rubycoin/rubycoin.conf" ]; then
    exit 0
fi

if [ ! -z ${MAX_CONNECTIONS:+x} ]; then
    echo "maxconnections=${MAX_CONNECTIONS}" >> "/rubycoin/rubycoin.conf"
fi

RPC_USER=${RPC_USER:-rubycoinrpc}
RPC_PASSWORD=${RPC_PASSWORD:-$(dd if=/dev/urandom bs=20 count=1 2>/dev/null | base64)}

echo "server=1" >> "/rubycoin/rubycoin.conf"
echo "rpcuser=${RPC_USER}" >> "/rubycoin/rubycoin.conf"
echo "rpcpassword=${RPC_PASSWORD}" >> "/rubycoin/rubycoin.conf"
echo "addnode=104.156.233.202:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=45.32.239.220:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=146.185.166.144:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=104.238.136.238:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=76.74.178.137:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=69.121.160.102:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=46.4.119.238:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=109.169.71.17:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=78.129.241.145:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=45.76.198.141:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=138.197.135.225:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=73.120.64.249:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=14.202.55.175:5937" >> "/rubycoin/rubycoin.conf"
echo "addnode=1.34.180.245:5937" >> "/rubycoin/rubycoin.conf"

#fi;
