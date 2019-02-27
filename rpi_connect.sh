#!/bin/bash
DEVELOPERKEY=
USERNAME=
PASSWORD=
SSHDEVICEADDRESS=
WEBDEVICEADDRESS=
LINUXUSER=
LOCALIP=

function initialize_token {
    TOKEN=$(curl -X POST \
        -H "developerkey":"$DEVELOPERKEY" \
        -d '{"username":"'$USERNAME'","password":"'$PASSWORD'"}' https://api.remot3.it/apv/v27/user/login \
    | jq -r '.token')
}

if [ "$1" == "localssh" ] ; then
    xfce4-terminal -e "ssh $LINUXUSER@$LOCALIP"
    elif [ "$1" == "remotessh" ] ; then
    initialize_token
    PROXYADDRESS=($(curl -X POST \
            -H "token:$TOKEN" \
            -H "developerkey:$DEVELOPERKEY" \
            -d '{"wait":"true","deviceaddress":"'$SSHDEVICEADDRESS'"}' \
    https://api.remot3.it/apv/v27/device/connect | jq -r '.connection.proxyserver,.connection.proxyport'))
    xfce4-terminal -e "ssh -l $LINUXUSER ${PROXYADDRESS[0]} -p ${PROXYADDRESS[1]}"
else
    initialize_token
    WEB=$(curl -X POST \
        -H "token:$TOKEN" \
        -H "developerkey:$DEVELOPERKEY" \
        -d '{"wait":"true","deviceaddress":"'$WEBDEVICEADDRESS'"}' \
    https://api.remot3.it/apv/v27/device/connect | jq -r '.connection.proxy')
    firefox $WEB
fi