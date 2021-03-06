#!/bin/bash
mkdir -p $HOME/.tmp
cd $HOME/.tmp
echo -e '"Mozilla/5.0 (Linux; Android 7.1.2; Moto G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3943.0 Mobile Safari/537.36"\n"Mozilla/5.0 (Android 7.1.2; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0"' >.ua
#font
URL='furiadetitas.net'
SRC=$(w3m -cookie -debug -dump_source -o accept_encoding=='*;q=0' "$URL/chat/titans/changeRoom" -o user_agent="$(shuf -n1 .ua)")
ACCESS=$(echo $SRC | sed "s/value\=/value\=\n/g" | grep '\<table' | cut -d\" -f2 | head -n1)
echo $ACCESS

#topic create
SID="13260" #subforum ID
LBL="Criar um tópico"
echo -e "error=$ACCESS&name="Topic name"&text="`cat << EOF
Text or bbcode here. Use \n for new line.
EOF`"&label=$LBL" >create.txt
SRC=$(w3m -cookie -debug -post create.txt -dump_source -o accept_encoding=='*;q=0' "$URL/forum/subforum/$SID/write?r=$ACCESS" -o user_agent="$(shuf -n1 .ua)")
exit
