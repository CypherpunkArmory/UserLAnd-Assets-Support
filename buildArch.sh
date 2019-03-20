#!/bin/bash

docker-compose -f docker/main.yml -f docker/$1.yml down
docker-compose -f docker/main.yml -f docker/$1.yml build
docker-compose -f docker/main.yml -f docker/$1.yml up
