#!/bin/bash

#check if we aleady have an instance
flag=""
hostname=""
if [ -e timestamp ]; then
    tmp=`grep expire timestamp | sed 's/expire:\(.*\)/\1/'`
    now=`date +%s`
    if [ $tmp -le $now ]; then
	echo "timestamp expired"
	flag=true
    else
	hostname=`grep hostname timestamp | sed 's/hostname:\(.*\)/\1/'`
    fi
    else 
    echo "Can't find timestamp, timestamp created"
    flag=true
fi

#request a new instance
if [ $flag ]; then 
    echo "Applying new HPC instance"
    echo -e "expire:\c" > timestamp
    tmp=`date +%s`
    ((tmp+=43200))
    echo $tmp >> timestamp
    tmp=`qsub RequestHPCGPU.sh | sed 's/\([0-9]*\).*/\1/'`
    hostname=`qstat -f $tmp | grep exec_host | sed 's/.*\(hpc[0-9]*\).*/\1/'`
    echo hostname:$hostname >> timestamp
fi
