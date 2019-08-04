#!/usr/bin/env bash


echo "Serialization dir: $1"
cd $1

cp best.th weights.th
tar zcvf model.tar.gz config.json weights.th vocabulary
