#!/bin/sh

# Originally the lnd command was run directly using command in lnd.install.yaml
# But the environment variable do not get evaluated, thus the restart.sh is needed


[ ${LND_DEBUG} = "debug" ] && set -x

lnd \
      --noseedbackup \
      --rpclisten=0.0.0.0:${LND_RPC_PORT} \
      --restlisten=0.0.0.0:${LND_REST_PORT} \
      --adminmacaroonpath=/shared/admin.macaroon \
      --tlsextradomain=${LND_HOST} \
      --tlsextraip=0.0.0.0 \
      --tlscertpath=/shared/tls.cert \
      --datadir=/root/.lnd \
      --bitcoin.active \
      --bitcoin.${COMMON_BTC_NETWORK} \
      --bitcoin.node=bitcoind \
      --bitcoind.rpchost=bitcoind:${BITCOIND_RPC_PORT} \
      --bitcoind.rpcuser=${BITCOIND_RPC_USER} \
      --bitcoind.rpcpass=${BITCOIND_RPC_PASSWORD} \
      --bitcoind.zmqpubrawtx=tcp://bitcoind:${BITCOIND_ZMQ_RAWTXS} \
      --bitcoind.zmqpubrawblock=tcp://bitcoind:${BITCOIND_ZMQ_BLK_HASH}

