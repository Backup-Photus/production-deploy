#!/bin/bash

docker-compose down
# Install openjdk-17
sudo apt install openjdk-17-jdk-headless
# Exposrt java-home for building 
export export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Dockerizing api-project
git clone git@github.com:Backup-Photus/photus.git
cd photus

./mvnw clean
./mvnw install
./mvnw package

docker build -t photus:latest .

cd ..


# Dockerrise extractor-project
git clone git@github.com:Backup-Photus/extractor-microservice.git
cd extractor-microservice

./mvnw clean
./mvnw install
./mvnw package

docker build -t extractor-micro:latest

cd ..


# Create volumes (if not available)
docker volume create mysql_data

# Start applications
# docker-compose up  -d 


# Clean ups 

rm -rf extractor-microservice
rm -rf photus