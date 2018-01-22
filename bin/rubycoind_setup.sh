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

if [ -z ${ENABLE_WALLET:+x} ]; then
    echo "disablewallet=1" >> "/rubycoin/rubycoin.conf"
fi

if [ ! -z ${MAX_CONNECTIONS:+x} ]; then
    echo "maxconnections=${MAX_CONNECTIONS}" >> "/rubycoin/rubycoin.conf"
fi

if [ ! -z ${RPC_SERVER:+x} ]; then
    RPC_USER=${RPC_USER:-rubycoinrpc}
    RPC_PASSWORD=${RPC_PASSWORD:-$(dd if=/dev/urandom bs=20 count=1 2>/dev/null | base64)}

    echo "server=1" >> "/rubycoin/rubycoin.conf"
    echo "rpcuser=${RPC_USER}" >> "/rubycoin/rubycoin.conf"
    echo "rpcpassword=${RPC_PASSWORD}" >> "/rubycoin/rubycoin.conf"
fi;
