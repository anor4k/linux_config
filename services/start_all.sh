#!/bin/bash
for i in $(ls -d */); do
  cd $i
  docker-compose up -d --remove-orphans --build
  cd ..
done
