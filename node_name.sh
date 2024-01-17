if [ -z $1 ]
then
        echo "ERROR: please input the 'node_name' command line argument.";
        exit 1;
fi

for file in {run.sh,myid.sh,shell.sh,spark-start-services.sh,zookeeper-start-services.sh,jupyter-lab-start.sh};
do sed -i "s/<node_name>/$1/g" $file; done;
