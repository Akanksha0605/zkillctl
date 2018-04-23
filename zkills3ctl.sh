#!/bin/sh
#$1 is bucket name and $2 is number

# if no command line arg given
#BUCKETNAME = "$(s3cmd s3 ls)"
#COUNT = "$(aws s3 ls $1 | wc -l)"
#echo "$1"

if [[ $# -eq 0 ]]
  then
    echo "Missing arguments!"
    echo "Use <bucket name> <number of file to delete>"
fi
    
if [ $# -eq 1 ]
then
	FILE=`find ~/.aws/ -name "credentials" | egrep '.*'`
	echo "${FILE}"
		if[ "$FILE" == "/home/ec2-user/.aws/credentials" ]; 
	then 	
		if  aws s3 ls "s3://$1" 2>&1 | grep -q 'An Error Occured' 
		then
    			echo "Error -1 no such file exists."
		else
			aws s3 ls $1
		fi
	else
		echo "Error -3 Cannot connect to S3"
	fi
fi

if [ $# -eq 2 ]
	then
		C=`aws s3 ls $1`
       		B=`aws s3 ls $1 | wc -l`
		if($2>$B)
		then
			echo "Error -2 there are $B logs in the bucket $1"
		else
			aws s3 ls $1 | sed -e :a -e '$d;N;2,3ba' -e 'P;D'
	
		fi
fi
					
