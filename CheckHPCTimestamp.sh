#!/bin/bash

#check if we aleady have an instance
flag=""
hostname=""
if [ -e timestamp ]; then
    tmp=`grep expire timestamp | sed 's/expire:\(.*\)/\1/'`
    now=`date +%s`
    if [ $tmp -le $now ]; then
	flag=true
    else
	hostname=`grep hostname timestamp | sed 's/hostname:\(.*\)/\1/'`
    fi
    else 
    flag=true
fi

#request a new instance
if [ $flag ]; then 
    echo -e "expire:\c" > timestamp
    data +%s >> timestamp
    tmp=`qsub RequestHPCGPU.sh | sed 's/\([0-9]*\).*/\1/'`
    hostname=`qstat -f $tmp | grep exec_host | sed 's/.*\(hpc[0-9]*\).*/\1/'`
    echo hostname:$hostname >> timestamp
fi
