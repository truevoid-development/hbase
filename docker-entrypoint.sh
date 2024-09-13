#!/bin/bash -e

stop() {
    echo "Got SIGTERM, stopping HBase..."
    $HBASE_HOME/bin/stop-hbase.sh
}
trap 'stop' SIGTERM

$HBASE_HOME/bin/start-hbase.sh

# Print HBase logs to STDOUT
tail -f $HBASE_HOME/logs/hbase--master-*.log &

# Wait until the HBase process is stoppped
HBASE_PID=$(cat /tmp/hbase--master.pid)
while kill -0 $HBASE_PID 2>/dev/null; do
    echo ALIVE
    sleep 5
done

echo "HBase stopped"
