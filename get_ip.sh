#!/bin/sh
ip_old=ip_old.txt
ip_now=ip_now.txt
log=log

## init ip.old

while [ ! -f $ip_old ]; do
        curl http://members.3322.org/dyndns/getip  > $ip_old
done
## get ip now

curl http://members.3322.org/dyndns/getip > $ip_now
## exit if fetch ip failed
if [ ! -s $ip_now ]; then
        exit 0
fi

/usr/bin/diff $ip_now $ip_old

if [ $? != 0 ]; then
        sed -i "\$a$(date) ------ IP change detected, previous ip: $(cat $ip_old), new ip: $(cat $ip_now)." $log
        cat $ip_now > $ip_old
        curl "https://sc.ftqq.com/SCUKEY.send?text=$(cat $ip_now)";
fi
