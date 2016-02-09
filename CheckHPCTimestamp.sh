#!/bin/bash

#check if we aleady have an instance
flag=""
host=""
if [ -e timestamp ]; then
    tmp=`grep expire timestamp | sed 's/expire:\(.*\)/\1/'`
    now=`date +%s`
    if [ $tmp -le $now ]; then
	echo "timestamp expired"
	flag=true
    else
	host=`grep hostname timestamp | sed 's/hostname:\(.*\)/\1/'`
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
    host=`qstat -n $tmp |  sed -n '$p' | sed 's/.*\(hpc[0-9]*\).*/\1/'`
    echo hostname:$host >> timestamp
fi

echo host: $host