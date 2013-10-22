#!/bin/bash

source ./common.sh

# There are a number of params that can be sent to this startup script
# SOLR_PORT: the port for this instance of solr to listen.
# SOLR_DATA_DIR: path to the location for storing the index files.
#
# Replication env params
# SOLR_MASTER: (true|false) if true, then this server is the master.  If not true, then this server is a slave.   It is best practice to always set this param.
# SOLR_MASTER_HOST: the host/post of the replication master

# Examples:  
# Run solr on port 9000, store files in /var/solr/index0, set as master for replication 
#     SOLR_PORT=9000 SOLR_MASTER=true SOLR_DATA_DIR=/var/solr/index0 sh start.sh
#
# Run solr on port 9001, store files in /var/solr/index1, set as slave for replication, set master as the instance in the example above
#     SOLR_PORT=9001 SOLR_MASTER=false SOLR_MASTER_HOST=localhost:9000 SOLR_DATA_DIR=/var/solr/index1 sh start.sh


if [ "$SOLR_PORT" = "" ]
then
  SOLR_PORT=8983;
fi

if [ "$SOLR_MASTER" = "true" ]
then
  SOLR_MASTER=true
  SOLR_SLAVE=false
else
  SOLR_MASTER=false
  SOLR_SLAVE=true
fi

if [ "$SOLR_DATA_DIR" = "" ]
then
  SOLR_DATA_DIR = "./data"
fi

RUN_ARGS=(${JAVA_OPTIONS[@]} -Xms2048M -Xmx6G -XX:PermSize=256M -XX:MaxPermSize=512M -Dreplication.master=$SOLR_MASTER -Dreplication.slave=$SOLR_SLAVE -Dreplication.host=$SOLR_MASTER_HOST -Dlogback.configurationFile=./etc/logback-prod.xml -Dsolr.data.dir=$SOLR_DATA_DIR -Djetty.port=$SOLR_PORT -server -jar location-services.war --jetty-config=./etc/jetty.xml --context-root=solr)
RUN_CMD=("$JAVA" ${RUN_ARGS[@]})

exec "${RUN_CMD[@]}" &> $PRGDIR/logs/stdout.log &
disown $!
echo $! > "$SERVICE_PID"
echo "STARTED $SERVICE_NAME `date`"