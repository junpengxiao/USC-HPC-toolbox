#!/bin/bash
sed -i '$ d' timestamp
task=`qstat -u junpengx | grep junpengx | sed 's/\([0-9]*\).*/\1/'`
host=`qstat -n $task | tail -n 1 | sed 's/.*\(hpc[0-9]*\).*/\1/'`
echo hostname:$host >> timestamp
export $host