#!/bin/bash
docker login -u sascararq -p Sascar@2019
docker build -t sascararquitetura/golang-docker-example-rest .
docker push sascararquitetura/golang-docker-example-rest
