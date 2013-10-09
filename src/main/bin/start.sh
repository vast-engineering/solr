#!/bin/bash

source ./common.sh

if [ "$SOLR_PORT" = "" ]
then
  SOLR_PORT=8983;
fi

RUN_ARGS=(${JAVA_OPTIONS[@]} -Xms2048M -Xmx6G -XX:PermSize=256M -XX:MaxPermSize=512M -Dlogback.configurationFile=./etc/logback-prod.xml -Dsolr.data.dir=./data -Djetty.port=$SOLR_PORT -server -jar executable-solr.war --jetty-config=./etc/jetty.xml --context-root=solr)
RUN_CMD=("$JAVA" ${RUN_ARGS[@]})

exec "${RUN_CMD[@]}" &> $PRGDIR/logs/stdout.log &
disown $!
echo $! > "$SERVICE_PID"
echo "STARTED $SERVICE_NAME `date`"
