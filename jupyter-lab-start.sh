docker exec -d <node_name> bash -c "jupyter-lab --ip 0.0.0.0 --allow-root"
docker exec <node_name> bash -c "jupyter server list"
