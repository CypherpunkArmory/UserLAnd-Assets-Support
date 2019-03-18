#!/bin/bash

docker-compose -f main.yml -f $1.yml down
docker-compose -f main.yml -f $1.yml build
docker-compose -f main.yml -f $1.yml up
mkdir -p release/assets
cp assets/* release/assets/
cp output/release/* release/assets/
tar -czvf release/$1-assets.tar.gz -C release/assets/ .
rm -rf release/assets
