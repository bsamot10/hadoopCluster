docker network create \
	-d overlay \
	--subnet 10.0.2.0/24 \
	--gateway 10.0.2.1 \
	--attachable hadoop-net
