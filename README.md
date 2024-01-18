# hadoopCluster
Docker container for a testing 3-node hadoop-yarn cluster.

The present deployment supports 5 services:

1. hdfs
2. spark
3. zookeeper
4. drill
5. hbase
   
## Requirements
3 Linux nodes with docker engine installed in each one of them. 

Resource requirements depend on the use case. I am using 4gb ram and 40gb storage on each node for testing purposes.

## Step 0
If the nodes do not share the same subnet, install openssh-server in every node and use it to produce public keys and provide the relevant authorizations to each node. 

## Step 1
Choose one of the nodes to be the leader of the docker swarm. 

Enter the leader node and type ```docker swarm init --advertise-addr <LEADER_NODE_IP>```, using the IP of the leader node.

The output of the above command generates the code that you should run in the remaining 2 nodes.

Copy the code and paste the command in each one of the 2 remaining nodes, so that the nodes join the swarm.

If necessary, check the instructions here: https://docs.docker.com/engine/reference/commandline/swarm_init/.

## Step 2
Load the repository's files and folders in each one of the nodes.

## Step 3
Create an overlay nertwork.

Run ```. overlay.sh``` in the leader node.

## Step 4
Assign an id and a name in every node. 

Run ```. node_id.sh 1``` in _master_ (_leader_) node, ```. node_id.sh 2``` in _worker-1_ node and ```. node_id.sh 3``` in _worker-2_ node.

Run ```. node_name.sh master``` in _master_ (_leader_) node, ```. node_name.sh worker-1``` in _worker-1_ node and ```. node_name.sh worker-2``` in _worker-2_ node.

## Step 5
Pull the image from my docker hub (https://hub.docker.com/repositories/bsamot10).

Run ```. pull.sh``` in every node.

## Step 6
Start container in every node.

Run ```. run.sh``` in every node.

## Step 7
Start services in every node.

Run ```. spark-start-services.sh``` in master node, to start _hdfs_ and _spark_ services in evey node.

Run ```. zookeeper-start-services.sh`` in every node, to start _zookeeper_, _drill_ and _hbase_ services in every node.

## Step 8
Enter the containers to verify that the services are running.

Run ```. shell.sh``` in every node.

Run ```jps``` inside the containers.

If everything has gone well, the ```jps``` command should print all 5 services.

If not, try to restart the missing services in each node.
