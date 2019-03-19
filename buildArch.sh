#!/bin/bash

docker-compose -f main.yml -f $1.yml down
docker-compose -f main.yml -f $1.yml build
docker-compose -f main.yml -f $1.yml up
