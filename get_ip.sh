#!/bin/sh
ip_old=ip_old.txt
ip_now=ip_now.txt
log=log

## init ip.old

while [ ! -f $ip_old ]; do
        curl http://members.3322.org/dyndns/getip > $ip_old
done
## get ip now

NEW_IP=$(curl http://members.3322.org/dyndns/getip)

if [ ! $NEW_IP ]; then
        exit 0
fi

echo $NEW_IP > $ip_now

/usr/bin/diff $ip_now $ip_old

if [ $? != 0 ];then
#       sed -i "\$a$(date) ------ IP change detected, previous ip: $(cat $ip_old), new ip: $(cat $ip_now)." $log        
        echo "$(date) ------ IP change detected, previous ip: $(cat $ip_old), new ip: $(cat $ip_now)." >> $log
        cat $ip_now > $ip_old
        curl "https://sc.ftqq.com/SCUKEY.send?text=$(cat $ip_now)";
fi
