#!/bin/bash
docker login -u fabiojapa -p xxxxxxxx
docker build -t fabiojapa/golang-docker-example-rest .
docker push fabiojapa/golang-docker-example-rest
