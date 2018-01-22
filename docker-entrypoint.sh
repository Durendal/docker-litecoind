#!/bin/sh
set -e

rubycoind_setup.sh

echo "################################################"
echo "# Configuration used: /rubycoin/rubycoin.conf  #"
echo "################################################"
echo ""
cat /rubycoin/rubycoin.conf
echo ""
echo "################################################"

exec rubycoind -daemon -datadir=/rubycoin -conf=/rubycoin/rubycoin.conf -printtoconsole "$@"
