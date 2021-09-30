#!/usr/bin/env bash

# Created by Andrzej Zahorski :)
result=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I \
    | grep "CtlRSSI\|agrCtlNoise" \
    | sed -e 's/^.*://g'  | { read -r a; read -r b; printf '%s\n' $((a-b)); })

printf 'Wi-Fi: '
# echo $result
if ((result > 40))
then
    echo "[++++]"
elif ((result > 25 && result <= 40))
then
    echo "[+++-]"
elif ((result > 15 && result <= 25))
then
    echo "[++--]"
elif ((result > 10 && result <= 15))
then
    echo "[+---]"
elif (( result > 0 &&result < 10  ))
then
    echo "[----]"
elif (( result == 0 ))
then
    echo "Off"
fi

