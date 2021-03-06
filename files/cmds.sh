#!/bin/bash    
fifo_name="/var/www/sr/_gen/streamingriver"
if [ ! -p $fifo_name ]; then
  mkfifo $fifo_name
fi

while true
do
  clientcmd=$(cat $fifo_name)
  IFS=" " read cmd param <<< $clientcmd

  case $cmd in
    "cmd1")
      /opt/tools/up.py
      /opt/tools/after.sh
    ;;
    "cmd2")
      /opt/tools/up.py
      /opt/tools/up2.py
      /opt/tools/after.sh
    ;;
    "restart")
      supervisorctl restart $param
    ;;
    *)
      echo "uknown command"
    ;;
esac

done
