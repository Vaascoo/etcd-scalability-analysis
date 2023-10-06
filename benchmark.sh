#!/bin/bash

ENDPOINTS=$1
NUM_CLIENTS=$2
NUM_CONNECTIONS=$3
TEST_TYPE=$4

# Join $4 until the end of the arguments
TEST_FULL=${@:4}

# chech if user has benchmark installed
if ! command -v benchmark &> /dev/null
then
    echo "benchmark could not be found, install it ;)"
fi

# find number of nodes in ENDPOINTS
IFS=',' read -ra ADDR <<< "$ENDPOINTS"
NUM_NODES=${#ADDR[@]}

# store benchmark output
rm -rf benchmark-output
mkdir -p benchmark-output

# store command that will be executed
COMMAND="benchmark --endpoints=$ENDPOINTS --clients=$NUM_CLIENTS --conns=$NUM_CONNECTIONS $TEST_FULL"
echo $COMMAND > benchmark-output/$NUM_NODES-$TEST_TYPE-$NUM_CLIENTS-$NUM_CONNECTIONS.txt
benchmark --endpoints=$ENDPOINTS --clients=$NUM_CLIENTS --conns=$NUM_CONNECTIONS $TEST_FULL >> benchmark-output/$NUM_NODES-$TEST_TYPE-$NUM_CLIENTS-$NUM_CONNECTIONS.txt
