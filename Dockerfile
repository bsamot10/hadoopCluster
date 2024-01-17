FROM ubuntu:22.04

USER root

RUN apt-get update
RUN apt-get dist-upgrade
RUN apt-get -y install openssh-server
RUN apt-get -y install gzip
RUN apt-get -y install tar
RUN apt-get -y install vim
RUN apt-get -y install curl
RUN apt-get -y install jq
RUN apt-get -y install cron
RUN apt-get -y install iputils-ping
RUN apt-get -y install net-tools
RUN apt-get -y install openjdk-11-jdk
RUN apt-get -y install kafkacat
RUN apt-get -y install scala
RUN apt-get -y install netcat
RUN apt-get -y install python3-pip

RUN pip install jupyterlab

RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.8.3/apache-zookeeper-3.8.3-bin.tar.gz
RUN tar -xzf apache-zookeeper-3.8.3-bin.tar.gz \
 && mv apache-zookeeper-3.8.3-bin /usr/local/zookeeper \
 && rm apache-zookeeper-3.8.3-bin.tar.gz

RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-3.3.6/hadoop-3.3.6.tar.gz
RUN tar -xzf hadoop-3.3.6.tar.gz \
 && mv hadoop-3.3.6 /usr/local/hadoop \
 && rm hadoop-3.3.6.tar.gz

RUN wget https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz
RUN tar -xzf spark-3.5.0-bin-hadoop3.tgz \
 && mv spark-3.5.0-bin-hadoop3 /usr/local/spark \
 && rm spark-3.5.0-bin-hadoop3.tgz

RUN wget https://archive.apache.org/dist/hbase/3.0.0-alpha-4/hbase-3.0.0-alpha-4-bin.tar.gz
RUN tar -xzf hbase-3.0.0-alpha-4-bin.tar.gz \
 && mv hbase-3.0.0-alpha-4 /usr/local/hbase \
 && rm hbase-3.0.0-alpha-4-bin.tar.gz

RUN wget https://archive.apache.org/dist/drill/drill-1.19.0/apache-drill-1.19.0.tar.gz 
RUN tar -xzf apache-drill-1.19.0.tar.gz \
 && mv apache-drill-1.19.0 /usr/local/drill \
 && rm apache-drill-1.19.0.tar.gz 

RUN ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -P "" \
 && cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV ZOOKEEPER_HOME=/usr/local/zookeeper
ENV HADOOP_HOME=/usr/local/hadoop
ENV SPARK_HOME=/usr/local/spark
ENV HBASE_HOME=/usr/local/hbase
ENV DRILL_HOME=/usr/local/drill
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME:$ZOOKEEPER_HOME/bin:$ZOOKEEPER_HOME:$HBASE_HOME/bin:$HBASE_HOME:$DRILL_HOME/bin:$DRILL_HOME:sbin

RUN mkdir -p $ZOOKEEPER_HOME/data \
 && mkdir -p $HADOOP_HOME/hdfs/namenode \
 && mkdir -p $HADOOP_HOME/hdfs/datanode

COPY config/ /tmp/

RUN mv /tmp/zookeeper/zoo.cfg $ZOOKEEPER_HOME/conf/zoo.cfg \
 && mv /tmp/zookeeper/myid $ZOOKEEPER_HOME/data/myid \
 && mv /tmp/hadoop-yarn/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
 && mv /tmp/hadoop-yarn/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml \
 && mv /tmp/hadoop-yarn/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml \
 && mv /tmp/hadoop-yarn/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml.template \
 && cp $HADOOP_HOME/etc/hadoop/mapred-site.xml.template $HADOOP_HOME/etc/hadoop/mapred-site.xml \
 && mv /tmp/hadoop-yarn/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml \
 && cp /tmp/workers $HADOOP_HOME/etc/hadoop/workers \
 && mv /tmp/workers $SPARK_HOME/conf/workers \
 && mv /tmp/spark/spark-env.sh $SPARK_HOME/conf/spark-env.sh \
 && mv /tmp/hbase/hbase-env.sh $HBASE_HOME/conf/hbase-env.sh \
 && mv /tmp/hbase/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml \
 && mv /tmp/hbase/regionservers $HBASE_HOME/conf/regionservers \
 && mv /tmp/hbase/backup-masters $HBASE_HOME/conf/backup-masters \
 && mv /tmp/drill/drill-override.conf $DRILL_HOME/conf/drill-override.conf

RUN chmod 755 -R $ZOOKEEPER_HOME \
 && chmod 755 -R $HADOOP_HOME \
 && chmod 755 -R $SPARK_HOME \
 && chmod 755 -R $HBASE_HOME \
 && chmod 755 -R $DRILL_HOME

COPY bash /home/root/bash
COPY test-spark-submit /home/root
RUN hdfs namenode -format
WORKDIR /home/root

ENTRYPOINT service ssh start; bash
