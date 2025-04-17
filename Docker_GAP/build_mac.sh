#!/bin/bash
docker build --platform=linux/amd64 --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t match_pulp .