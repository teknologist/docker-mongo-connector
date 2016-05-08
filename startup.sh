#!/bin/bash

echo "rs.isMaster()" > is_master_check
is_master_result=`mongo --host ${mongo}:27017< is_master_check`

expected_result="\"ismaster\" : true"

mongo="${MONGO:-mongo}"
elasticsearch="${ELASTICSEARCH:-elasticsearch}"
namespaces="${NAMESPACES:-namespaces}"
algolia=${ALGOLIA:-unknown}

echo "Starting mongo connecteor 2.1 with: "
echo "Mongo: ${mongo}"
echo "Algolia: ${algolia}"

while true;
do
  if [ "${is_master_result/$expected_result}" = "$is_master_result" ] ; then
    echo "Waiting for Mongod node to assume primary status..."
    sleep 3
    is_master_result=`mongo --host ${mongo}:27017< is_master_check`
  else
    echo "Mongod node is now primary"
    break;
  fi
done

sleep 1


mongo-connector --auto-commit-interval=0 --oplog-ts=/data/oplog.ts -n ${namespaces} --oplog-ts=/data/oplog.ts -m ${mongo}:27017 -t ${algolia} -d algolia_doc_manager

/usr/bin/tail -f /mongo-connector.log