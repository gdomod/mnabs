#!/bin/bash


if [ ! -f /root/config.conf ]; then
RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
RANDOM=$(( $RANDOM % 10000 + 12000 ));
IP=$(curl -s4 icanhazip.com) 
echo -e "rpcuser=$RPCUSER\n\
rpcpassword=$RPCPASSWORD\n\
rpcport=$RANDOM\n\
port=$PORT\n\
rpcallowip=::/0\n\
rpcbind=0.0.0.0\n\
listen=1\n\
server=1\n\
daemon=0\n\
printtoconsole=1\n\
maxconnections=256\n\
logtimestamps=1\n\
masternode=1\n\
externalip=$IP:$PORT" >> /root/config.conf
fi

cron

/usr/local/bin/absoluted -conf=/root/config.conf -masternodeprivkey=$1
