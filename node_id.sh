if [ -z $1 ]
then
        echo "ERROR: please input the 'node_id' command line argument.";
        exit 1;
fi

for file in {run.sh,shell.sh,services.sh,cleanup.sh,conf/myid,conf/server.properties,conf/connect-distributed.properties,myid.sh,server-properties.sh,connect-properties.sh};
do sed -i "s/<node_id>/$1/g" $file; done;
