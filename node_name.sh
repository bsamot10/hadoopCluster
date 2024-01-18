if [ -z $1 ]
then
        echo "ERROR: please input the 'node_name' command line argument.";
        exit 1;
fi

for file in {run.sh,myid.sh,hbase-site.sh,shell.sh,spark-start-services.sh,zookeeper-start-services.sh,jupyter-lab-start.sh,config/hbase/hbase-site-worker.xml}; 
do
        if ! ([ $1 == master ] && [ $file == 'config/hbase/hbase-site-worker.xml' ]);
        then
                sed -i "s/<node_name>/$1/g" $file
        fi
done
