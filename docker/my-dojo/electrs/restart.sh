#!/bin/sh

cd /home/user

# Generate electrs.toml with bitcoind rpc credentials
# For documentation see https://github.com/romanz/electrs/blob/master/doc/usage.md
echo "cookie = \"$BITCOIND_RPC_USER:$BITCOIND_RPC_PASSWORD\"" >  /home/user/electrs.toml

electrs -vvvv --timestamp --db-dir /home/user/db \
        --jsonrpc-import                         \
        --daemon-rpc-addr=bitcoind:28256         \
        --electrum-rpc-addr=172.28.1.10:50001    \
        ${ELECTRS_OPTIONS}
