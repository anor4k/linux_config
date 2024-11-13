#!/bin/bash
source ./export_aws_creds.sh
for i in $(ls -d */); do
  cd $i
  docker-compose up -d --build --remove-orphans
  cd ..
done