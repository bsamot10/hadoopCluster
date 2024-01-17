docker run -d \
	--name <node_name> \
	-h <node_name> \
	--network overlay-hadoop \
	--ip "10.0.2.1<node_id>" \
	-p 9868:9868 \
	-p 9870:9870 \
	-p 8088:8088 \
	-p 8080:8080 \
	-p 8888:8888 \
	-p 8047:8047 \
	-p 16010:16010 \
	-itd bsamot10/spark-hadoop-cluster:latest

. myid.sh
