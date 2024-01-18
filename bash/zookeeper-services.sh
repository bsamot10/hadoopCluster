#!/bin/bash

$ZOOKEEPER_HOME/bin/zkServer.sh start
sleep 10
echo -e '\n'
jps
echo -e '\n'

$DRILL_HOME/bin/drillbit.sh start
sleep 10
echo -e '\n'
jps
echo -e '\n'

if [ $(hostname -f) == 'master' ]
then
        $HBASE_HOME/bin/start-hbase.sh
        sleep 10
        echo -e '\n'
        jps
        echo -e '\n'
fi
