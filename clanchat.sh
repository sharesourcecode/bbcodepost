#!/bin/bash
URL='http://furiadetitas.net'
echo -e '"Mozilla/5.0 (Linux; Android 9.0.0; SM-G955U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.96 Mobile Safari/537.36"' >.ua

_sendmsg () {
#send msg1
rpt=0
until [[ $rpt -eq 75 ]]; do

SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
SND1="Enviar"
#/
echo -e "s=$ACCESS&text="`cat << EOF
　 　　 　
EOF`"&send_message=$SND1" >chat.txt
#\
SRC=$(w3m -cookie -debug -post chat.txt -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")

#send msg2
SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
SND1="Enviar"
#/
echo -e "s=$ACCESS&text="`cat << EOF
　 　
EOF`"&send_message=$SND1" >chat.txt
#\
SRC=$(w3m -cookie -debug -post chat.txt -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
rpt=$[$rpt+1]
done
}
_sendmsg
#delete
rpt=0
SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/clan/changeRoom/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/del/' | head -n1 | cut -d\' -f2)

until [[ $rpt -eq 150 ]]; do

SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/del/' | head -n1 | cut -d\' -f2)
rpt=$[$rpt+1]
done
