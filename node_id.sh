if [ -z $1 ]
then
        echo "ERROR: please input the 'node_id' command line argument.";
        exit 1;
fi

for file in {run.sh,config/zookeeper/myid,config/hbase-site-worker.xml};
if ! [ [ $1 == 1 ] && [ $file == 'hbase-site-worker.xml' ] ] ;
do sed -i "s/<node_id>/$1/g" $file; done;
fi
