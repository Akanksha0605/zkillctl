:
#! /bin/bash
#Akanksha Khandelwal

#Detect zombie process (PID, STAT)
	ps aux | awk '{ print $8 " " $2 }' | grep -w Z
if [ "$8" = Z ]
#Get parent ID and kill 
then 
		S=$( ps ax | awk '{print $1}' | grep -v "PID" | xargs -n 1 ps lOp | awk '{print "PID: "$3" status: "$10"}' | grep ": Z")
		kill -9 $(ps -A -ostat,ppid | awk '/[zZ]/ && !a[$2]++
{print $2}')
#To generate logs of priority info facility daemon

		logger -p daemon.info detected zombie process: $S and KILLED successfully!
else
		logger -p daemon.info detected zombie process: $S. Could not kill!
fi
