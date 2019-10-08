#!/bin/bash

#
# Run this script to create all the Docker images used by Codeboard.
#
# Copyright: H.-Christian Estler
#

echo "############################################"
echo "# Cobo Docker - Building all Docker Images #"
echo "############################################"
echo ""
echo "This script will create all Docker images used by Codeboard and Mantra."
echo ""
echo "IMPORTANT: make sure that Mantra is NOT RUNNING. Its monitoring features"
echo "will interfere with the creation of Docker images."
echo ""
echo "Press any key to continue (Ctrl+c to quit)."
read INPUT

# the base Ubuntu image which all the other images use
docker build --file="docker_build_files/cobo_ubuntu.docker" --tag="cobo/ubuntu" --rm=true .

# language specific images
docker build --file="docker_build_files/java_and_java-junit.docker" --tag="cobo/java" --rm=true .
docker build --file="docker_build_files/py_and_py-unittest.docker" --tag="cobo/python" --rm=true .

echo "##########################################"
echo "# Cobo Docker - Done building all images #"
echo "##########################################"
