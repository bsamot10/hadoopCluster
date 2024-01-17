#!/bin/bash

$ZOOKEEPER_HOME/bin/zkServer.sh start
sleep 10
jps -lm

$DRILL_HOME/bin/drillbit.sh start
sleep 10
jps -lm



