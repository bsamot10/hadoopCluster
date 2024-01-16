/usr/local/spark/bin/spark-submit   \
        --master yarn   \
        --deploy-mode client     \
        --num-executors 2   \
        --executor-cores 1   \
        --executor-memory 1g \
        test.py
