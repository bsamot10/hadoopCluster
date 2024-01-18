if [ -z $1 ]
then
        echo "ERROR: please input the 'node_id' command line argument.";
        exit 1;
fi

for file in {run.sh,config/zookeeper/myid,config/hbase/hbase-site-worker.xml}; 
do
        if ! ([ $1 == 1 ] && [ $file == 'config/hbase/hbase-site-worker.xml' ]);
        then
                sed -i "s/<node_id>/$1/g" $file
        fi
done
