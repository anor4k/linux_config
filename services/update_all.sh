#!/bin/bash
for i in $(ls -d */); do
  cd $i
  docker-compose pull && docker-compose up -d --remove-orphans --build
  cd ..
done
