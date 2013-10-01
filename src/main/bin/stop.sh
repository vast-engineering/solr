#!/bin/bash

source ./common.sh

echo "Stopping $SERVICE_NAME: "
PID=$(cat "$SERVICE_PID" 2>/dev/null)
kill "$PID" 2>/dev/null

TIMEOUT=30
while running $SERVICE_PID; do
   if (( TIMEOUT-- == 0 )); then
       kill -KILL "$PID" 2>/dev/null
   fi

   sleep 1
done

rm -f "$SERVICE_PID"
echo OK