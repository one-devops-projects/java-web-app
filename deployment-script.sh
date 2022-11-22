#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 537960581474.dkr.ecr.us-east-1.amazonaws.com

docker pull 537960581474.dkr.ecr.us-east-1.amazonaws.com/java-web-app:${BUILD_NUMBER}

docker rm -f maven-web-app || true

docker run -d --name maven-web-app -p 8080:8080 537960581474.dkr.ecr.us-east-1.amazonaws.com/java-web-app:${BUILD_NUMBER}
